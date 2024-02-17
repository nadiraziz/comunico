# yourapp/views.py
from rest_framework.generics import RetrieveUpdateAPIView
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from rest_framework import status, permissions
from rest_framework_simplejwt.tokens import RefreshToken, AccessToken
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.generics import CreateAPIView, RetrieveUpdateAPIView
from .models import CustomUser
from .serializers import CustomUserSerializer, UserProfileSerializer


class SignUpView(CreateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = CustomUserSerializer
    permission_classes = [permissions.AllowAny]

    def create(self, request, *args, **kwargs):
        required_fields = ['name', 'email',
                           'password', 'date_of_birth', 'gender']
        missing_fields = [
            field for field in required_fields if not request.data.get(field)]

        if missing_fields:
            return Response({'message': f'The following fields are required: {", ".join(missing_fields)}'}, status=status.HTTP_400_BAD_REQUEST)

        response = super().create(request, *args, **kwargs)

        # Generate tokens after successful sign-up
        user = CustomUser.objects.get(email=request.data['email'])
        refresh = RefreshToken.for_user(user)
        access = AccessToken.for_user(user)

        # Include tokens and user details in the response
        response.data['access_token'] = str(access)
        response.data['refresh_token'] = str(refresh)
        response.data['message'] = "Account created successfully."

        return response


class SignInView(APIView):

    def post(self, request, *args, **kwargs):
        required_fields = ['email', 'password']
        missing_fields = [
            field for field in required_fields if not request.data.get(field)]

        if missing_fields:
            return Response({'message': f'The following fields are required: {", ".join(missing_fields)}'}, status=status.HTTP_400_BAD_REQUEST)

        email = request.data.get('email')
        password = request.data.get('password')

        user = CustomUser.objects.filter(email=email).first()
        print(user)

        if user and user.check_password(password):
            refresh = RefreshToken.for_user(user)
            access_token = str(refresh.access_token)
            refresh_token = str(refresh)
            return Response({'message': 'Login successful', 'user_id': user.id, 'access_token': access_token, 'refresh_token': refresh_token})
        else:
            return Response({'message': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)


class ProfileView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        try:
            user_profile = CustomUser.objects.get(pk=request.user.id)
            serializer = CustomUserSerializer(user_profile)
            return Response(serializer.data)
        except CustomUser.DoesNotExist:
            return Response(
                {"detail": "User profile not found",
                    "code": "user_profile_not_found"},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            return Response(
                {"detail": f"An error occurred: {str(e)}",
                 "code": "server_error"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )


class LogoutView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request):
        required_fields = ['refresh_token']
        missing_fields = [
            field for field in required_fields if not request.data.get(field)]

        if missing_fields:
            return Response({'message': f'The following fields are required: {", ".join(missing_fields)}'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            refresh_token = request.data.get("refresh_token")
            decoded_token = RefreshToken(refresh_token)
            decoded_token.blacklist()
            return Response({"message": "Logout successful"}, status=status.HTTP_200_OK)

        except Exception as e:
            return Response({"message": f"Error during logout: {str(e)}"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
