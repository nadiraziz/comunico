# app/views.py
from datetime import date
from .serializers import VideoTipsSerializer
from .models import VideoTips
from rest_framework import viewsets, status, serializers
from rest_framework.response import Response
from .models import UserVideo
from .serializers import UserVideoSerializer, AnalysisHistorySerializer
from .analysis import analyze_communication
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth.models import User
import os
from datetime import datetime
from rest_framework import generics, permissions


class UserVideoViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
    queryset = UserVideo.objects.all()
    serializer_class = UserVideoSerializer

    def create(self, request, *args, **kwargs):
        # Print request data for debugging
        print("Request data:", request.data)
        # Assuming you're using the default User model
        request.data['user'] = request.user.id
        # Validate video format before continuing
        video_file = request.data.get('video')

        # Generate a unique filename based on user ID and timestamp
        user_id = request.user.id
        original_filename = video_file.name  # Access the name directly
        timestamp = datetime.now().strftime('%Y%m%d%H%M%S')
        filename, extension = os.path.splitext(original_filename)
        new_filename = f"user_{user_id}_{timestamp}{extension}"
        video_file.name = new_filename  # Update the name directly

        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        try:
            video_instance = serializer.save()

            # Update the filename in the database

            # Print created video instance for debugging
            print("Video instance created:", video_instance)
            self._perform_video_analysis(video_instance)
            response_serializer = UserVideoSerializer(video_instance)
            return Response(response_serializer.data, status=status.HTTP_201_CREATED)
        except serializers.ValidationError as e:
            # Print validation error for debugging
            print("Validation error:", e.detail)
            return Response({'error': 'Invalid data. Please check the provided information.'}, status=status.HTTP_400_BAD_REQUEST)

    def list(self, request, *args, **kwargs):
        user = self.request.user
        queryset = UserVideo.objects.filter(user=user.id)
        print(queryset)
        serializer = AnalysisHistorySerializer(queryset, many=True)
        return Response(serializer.data)

    def _perform_video_analysis(self, video_instance):
        # Proceed with video analysis
        analysis_results = analyze_communication(video_instance.video.path)
        # Calculate performance score based on voice and face emotions
        # Assign the performance score to the UserVideo instance
        video_instance.voice_emotion = analysis_results['voice_emotion']
        video_instance.face_emotion = analysis_results['face_emotion']
        video_instance.performance_score = analysis_results['performance_score']
        video_instance.feedback = analysis_results['feedback']
        video_instance.additional_feedback = analysis_results['additional_feedback']
        video_instance.save()


class VideoTipsListView(generics.ListAPIView):
    serializer_class = VideoTipsSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        user = self.request.user

        # Calculate the minimum and maximum birth years based on age range
        gender = user.gender.lower() if user.gender else None
        age = date.today().year - user.date_of_birth.year
        print(age)

        return VideoTips.objects.filter(
            gender=gender,
            min_age__lte=age,
            max_age__gte=age
        ).order_by('-created_at')
