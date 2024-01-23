# app/serializers.py
from rest_framework import serializers
from .models import UserVideo


class UserVideoSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserVideo
        fields = '__all__'


class AnalysisHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = UserVideo
        fields = ['id', 'stage_fear_score', 'boldness_score',
                  'communication_skills_score', 'vocabulary_usage_score', 'created_at']
