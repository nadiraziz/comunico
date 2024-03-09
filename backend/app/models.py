# app/models.py
from django.db import models
# Adjust the import path based on your app structure
from user.models import CustomUser


class UserVideo(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    video = models.FileField(upload_to='videos/')
    voice_emotion = models.CharField(null=True, blank=True, max_length=500)
    face_emotion = models.CharField(null=True, blank=True, max_length=500)
    feedback = models.CharField(null=True, blank=True, max_length=500)
    performance_score = models.IntegerField(null=True, blank=True)  # New field

    additional_feedback = models.CharField(
        null=True, blank=True, max_length=500)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Video {self.id} - User: {self.user.email}"


class VideoTips(models.Model):
    video_title = models.CharField(null=True, blank=True, max_length=100)
    video_description = models.CharField(
        null=True, blank=True, max_length=1000)
    video_link = models.CharField(null=True, blank=True, max_length=10000)
    gender = models.CharField(null=True, blank=True, max_length=500)
    min_age = models.IntegerField(null=True, blank=True)
    max_age = models.IntegerField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def save(self, *args, **kwargs):
        # Ensure gender is stored in lowercase
        self.gender = self.gender.lower() if self.gender else None
        super().save(*args, **kwargs)

    def __str__(self):
        return f"Video {self.video_title} - Gender: {self.gender}"
