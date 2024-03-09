# app/views.py

from rest_framework import viewsets, status
from rest_framework.response import Response
from .models import Feedback
from .serializers import FeedbackSerializer
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth.models import User


class FeedbackViewSet(viewsets.ModelViewSet):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer
    permission_classes = [IsAuthenticated]

    def create(self, request, *args, **kwargs):

        user = request.data.copy()  # Create a mutable copy of request.data
        user['user'] = request.user.id  # Add user to the mutable data

        serializer = self.get_serializer(data=user)
        serializer.is_valid(raise_exception=True)

        try:
            feedback_instance = serializer.save()
            return Response(FeedbackSerializer(feedback_instance).data, status=status.HTTP_201_CREATED)
        except serializers.ValidationError as e:
            return Response({'error': 'Invalid data. Please check the provided information.'}, status=status.HTTP_400_BAD_REQUEST)
