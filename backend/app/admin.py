# app/admin.py

from django.contrib import admin
from .models import UserVideo, VideoTips


admin.site.register(UserVideo)
admin.site.register(VideoTips)
