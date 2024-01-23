# app/models.py
from django.db import models


class UserVideo(models.Model):
    video = models.FileField(upload_to='videos/')
    stage_fear_score = models.FloatField(null=True, blank=True)
    boldness_score = models.FloatField(null=True, blank=True)
    communication_skills_score = models.FloatField(null=True, blank=True)
    vocabulary_usage_score = models.FloatField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Video {self.id}"
