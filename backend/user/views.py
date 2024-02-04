# yourapp/views.py
from rest_framework import status, permissions
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.views import APIView
from rest_framework import permissions
from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import CreateAPIView, RetrieveUpdateAPIView
from .models import CustomUser
from .serializers import CustomUserSerializer


class SignUpView(CreateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = CustomUserSerializer


class SignInView(APIView):
    permission_classes = [permissions.AllowAny]

    def post(self, request, *args, **kwargs):
        email = request.data.get('email')
        password = request.data.get('password')

        user = CustomUser.objects.filter(email=email).first()

        if user and user.check_password(password):
            refresh = RefreshToken.for_user(user)
            access_token = str(refresh.access_token)
            refresh_token = str(refresh)
            return Response({'message': 'Login successful', 'user_id': user.id, 'access_token': access_token, 'refresh_token': refresh_token})
        else:
            return Response({'message': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)


class ProfileView(RetrieveUpdateAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = CustomUserSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, *args, **kwargs):
        return self.retrieve(request, *args, **kwargs)

    def put(self, request, *args, **kwargs):
        return self.update(request, *args, **kwargs)


class LogoutView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request):
        try:
            # Get the refresh token from the request header
            refresh_token = request.data["refresh_token"]

            # Decode the refresh token and blacklist it
            decoded_token = RefreshToken(refresh_token)
            decoded_token.blacklist()

            return Response({"message": "Logout successful"}, status=status.HTTP_200_OK)

        except KeyError:
            return Response({"message": "Refresh token not provided"}, status=status.HTTP_400_BAD_REQUEST)
