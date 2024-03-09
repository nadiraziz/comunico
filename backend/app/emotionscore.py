
def calculate_performance_score(voice_emotion, face_emotion):
    # Your logic to calculate the performance score based on voice and face emotions
    # Example: Add scores for each emotion and normalize the result
    voice_score = get_voice_emotion_score(voice_emotion)
    face_score = get_face_emotion_score(face_emotion)

    # Combine and normalize scores
    total_score = (voice_score + face_score) / 2
    # Assuming you want a percentage
    normalized_score = round(total_score * 10)

    return normalized_score


def get_voice_emotion_score(voice_emotion):
    # Your logic to assign scores based on voice emotions
    # Example: Assign a score of 0-10 based on the positivity of the emotion
    if voice_emotion == 'Happy':
        return 10.0
    elif voice_emotion == 'Neutral':
        return 8.0
    elif voice_emotion == 'fearful':
        return 6.0
    elif voice_emotion == 'disgust':
        return 4.0
    elif voice_emotion == 'angry':
        return 2.0
    else:
        return 0.0


def get_face_emotion_score(face_emotion):
    # Your logic to assign scores based on face emotions
    # Example: Assign a score of 0-10 based on the positivity of the emotion
    if face_emotion == 'Interested':
        return 10.0
    elif face_emotion == 'Neutral':
        return 6.0
    elif face_emotion == 'Disappointed':
        return 2.0
