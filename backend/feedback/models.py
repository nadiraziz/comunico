# app/models.py

from django.db import models
# Adjust the import path based on your app structure
from user.models import CustomUser


class Feedback(models.Model):
    star_count = models.PositiveIntegerField()
    description = models.TextField()
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Feedback {self.id} - User: {self.user.email}"
