# app/models.py
from django.db import models


class UserVideo(models.Model):
    video = models.FileField(upload_to='videos/')
    voice_emotion = models.CharField(null=True, blank=True, max_length=500)
    face_emotion = models.CharField(null=True, blank=True, max_length=500)
    feedback = models.CharField(null=True, blank=True, max_length=500)
    additional_feedback = models.CharField(
        null=True, blank=True, max_length=500)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Video {self.id}"
