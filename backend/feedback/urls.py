# app/urls.py
from django.urls import path
from .views import FeedbackViewSet

urlpatterns = [
    path('create/', FeedbackViewSet.as_view(
        {'post': 'create'}), name='create'),
]
