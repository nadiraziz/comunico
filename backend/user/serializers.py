# yourapp/serializers.py
from rest_framework import serializers
from .models import CustomUser


class CustomUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['id', 'name', 'email', 'date_of_birth',
                  'gender', 'is_active', 'is_staff']
