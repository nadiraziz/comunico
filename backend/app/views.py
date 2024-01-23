# app/views.py
from rest_framework import viewsets, status, serializers
from rest_framework.response import Response
from .models import UserVideo
from .serializers import UserVideoSerializer, AnalysisHistorySerializer
from .analysis import analyze_video


class UserVideoViewSet(viewsets.ModelViewSet):
    queryset = UserVideo.objects.all()
    serializer_class = UserVideoSerializer

    def create(self, request, *args, **kwargs):
        # Print request data for debugging
        print("Request data:", request.data)

        # Validate video format before continuing
        video_file = request.data.get('video')
        if not self._is_valid_video_format(video_file):
            error_message = {
                'error': 'Invalid file format. Please upload a valid video file.'
            }
            return Response(error_message, status=status.HTTP_400_BAD_REQUEST)

        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        try:
            video_instance = serializer.save()
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
        queryset = UserVideo.objects.all()
        serializer = AnalysisHistorySerializer(queryset, many=True)
        return Response(serializer.data)

    def _perform_video_analysis(self, video_instance):
        # Check if the uploaded file is a video
        # allowed_video_formats = [
        #     'video/mp4', 'video/quicktime', 'video/x-msvideo', 'video/x-flv', 'video/webm']

        # if video_instance.video.file.content_type not in allowed_video_formats:
        #     # If not a video format, handle accordingly
        #     error_message = {
        #         'error': 'Invalid file format. Please upload a valid video file.'}
        #     raise serializers.ValidationError(error_message)

        # Proceed with video analysis
        analysis_results = analyze_video(video_instance.video.path)
        video_instance.stage_fear_score = analysis_results.get(
            'stage_fear', 0)
        video_instance.boldness_score = analysis_results.get('boldness', 0)
        # video_instance.communication_skills_score = analysis_results.get(
        #     'communication_skills', 0)
        # video_instance.vocabulary_usage_score = analysis_results.get(
        #     'vocabulary_usage', 0)
        video_instance.save()

    def _is_valid_video_format(self, video_file):
        allowed_video_formats = [
            'video/mp4', 'video/quicktime', 'video/x-msvideo', 'video/x-flv', 'video/webm']

        if video_file and hasattr(video_file, 'content_type') and video_file.content_type not in allowed_video_formats:
            return False
        return True
