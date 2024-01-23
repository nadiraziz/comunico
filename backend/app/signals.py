# app/signals.py
from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import UserVideo
from .analysis import analyze_video


@receiver(post_save, sender=UserVideo)
def analyze_video_on_create(sender, instance, created, **kwargs):
    if created:
        analysis_results = analyze_video(instance.video.path)
        instance.stage_fear_score = analysis_results['stage_fear']
        instance.boldness_score = analysis_results['boldness']
        # instance.communication_skills_score = analysis_results['communication_skills']
        # instance.vocabulary_usage_score = analysis_results['vocabulary_usage']
        instance.save()
