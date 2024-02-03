# app/signals.py
from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import UserVideo
from .analysis import analyze_communication


@receiver(post_save, sender=UserVideo)
def analyze_video_on_create(sender, instance, created, **kwargs):
    if created:
        analysis_results = analyze_communication(instance.video.path)
        instance.voice_emotion = analysis_results['voice_emotion']
        instance.face_emotion = analysis_results['face_emotion']
        instance.feedback = analysis_results['feedback']
        instance.additional_feedback = analysis_results['additional_feedback']
        instance.save()
