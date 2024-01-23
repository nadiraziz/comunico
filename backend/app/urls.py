# app/urls.py
from django.urls import path
from .views import UserVideoViewSet

urlpatterns = [
    path('videos/', UserVideoViewSet.as_view(
        {'post': 'create', 'get': 'list'}), name='user-video-list'),
    # Add more paths as needed
]
