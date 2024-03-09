# app/serializers.py
from user.models import CustomUser
from django.db import models
from rest_framework import serializers
from .models import UserVideo, VideoTips


class UserVideoSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserVideo
        fields = '__all__'


class AnalysisHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = UserVideo
        fields = ['id', 'video', 'voice_emotion',
                  'face_emotion', 'feedback', 'additional_feedback', 'created_at', 'performance_score']


class VideoTipsSerializer(serializers.ModelSerializer):
    class Meta:
        model = VideoTips
        fields = '__all__'
