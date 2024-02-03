import os
import cv2
import numpy as np
from keras.models import model_from_json
from pydub import AudioSegment
from moviepy.editor import VideoFileClip
import librosa
import joblib
from statistics import mode
import matplotlib.pyplot as plt


# Path
video_path_to_analyze = './app/demo/female/disappointed.mp4'
voice_model_path = './app/ver/model/speech_emotion_model.pkl'
face_model_path = './app/fer/model/network.json'
weights_path = './app/fer/model/Education.h5'

# Additional Feedback Messages
additional_feedback_dict = {
    'happy_Interested': "Your joyful voice and interested facial expressions create a positive and engaging atmosphere!",
    'calm_Disappointed': "While your voice tone is calm, disappointed facial expressions might need adjustment for better alignment.",
    'fearful_Neutral': "A fearful voice combined with neutral facial expressions may create a mismatch. Ensure consistency in emotions for better impact.",
    'happy_Neutral': "Your happy voice paired with neutral facial expressions provides a balanced and approachable communication style.",
    'calm_Interested': "A calm voice with interested facial expressions adds a composed yet engaging touch to your communication.",
    'fearful_Interested': "Your fearful voice and interested facial expressions convey a mix of emotions. Consider emphasizing key points for clarity.",
    'calm_Neutral': "A calm voice and neutral facial expressions create a composed communication style. Ensure your message is effectively delivered.",
    'happy_Disappointed': "Your happy voice and disappointed facial expressions may create a mismatch. Consider aligning your expressions with the tone of your voice.",
    'fearful_Disappointed': "A fearful voice paired with disappointed facial expressions may convey confusion. Clarify your message to avoid misunderstandings.",
    'neutral_Interested': "Neutral voice tones and interested facial expressions strike a balance. Ensure your communication remains engaging.",
    'neutral_Disappointed': "Neutral voice tones with disappointed facial expressions may create ambiguity. Ensure your expressions align with the intended message."
}


# voice feedback dict
voice_feedback_dict = {
    'Happy': "Your voice sounds happy and upbeat. Great job conveying positivity!",
    'Neutral': "Your voice tone is neutral. Consider adding more expressiveness to engage listeners.",
    'Sad': "Your voice conveys sadness. Make sure your message aligns with the intended tone.",
    'Calm': "Your voice tone is calm. Consider maintaining a composed tone for effective communication.",
    'Fearful': "Your voice conveys fear. Ensure your message aligns with the intended tone."
}


# face emotion feedback dict
face_feedback_dict = {
    'Interested': "Your facial expressions show interest. Keep up the engaging expressions!",
    'Neutral': "Your facial expressions appear neutral. Experiment with more varied expressions for impact.",
    'Disappointed': "Your facial expressions seem disappointed. Ensure your non-verbal cues align with your message."
}


def analyze_communication(video_path):

    # Load the voice model here
    voice_model = joblib.load(voice_model_path)

    def video_to_audio(video_path, audio_path):
        video_clip = VideoFileClip(video_path)
        audio_clip = video_clip.audio
        audio_clip.write_audiofile(audio_path, codec='pcm_s16le', fps=44100)
        video_clip.close()
        audio_clip.close()

    def extract_feature(file_name, mfcc=True, chroma=True, mel=True):
        audio = AudioSegment.from_wav(file_name)
        y = np.array(audio.get_array_of_samples()) / 32768.0

        features = []
        if mfcc:
            mfccs = np.mean(librosa.feature.mfcc(
                y=y, sr=audio.frame_rate, n_mfcc=13), axis=1)
            features.extend(mfccs)
        if chroma:
            chroma = np.mean(librosa.feature.chroma_stft(
                y=y, sr=audio.frame_rate), axis=1)
            features.extend(chroma)
        if mel:
            mel = np.mean(librosa.feature.melspectrogram(
                y=y, sr=audio.frame_rate), axis=1)
            features.extend(mel)

        features = np.pad(features, (0, 180 - len(features)))

        return features

    def analyze_video_emotion(video_path, model):
        features = extract_feature(
            video_path, mfcc=True, chroma=True, mel=True)
        features = features.reshape(1, -1)
        predicted_emotion = model.predict(features)[0]

        return predicted_emotion

    def load_model(model_path, weights_path):
        with open(model_path, 'r') as json_file:
            loaded_model_json = json_file.read()
            loaded_model = model_from_json(loaded_model_json)
        loaded_model.load_weights(weights_path)
        return loaded_model

    def preprocess_frame(frame, target_size=(64, 64)):
        frame = cv2.resize(frame, target_size)
        frame_array = np.array(frame) / 255.0
        frame_array = np.expand_dims(frame_array, axis=0)
        return frame_array

    def predict_face_emotion(model, frame):
        processed_frame = preprocess_frame(frame)
        prediction = model.predict(processed_frame)
        emotions = ['Disappointed', 'Neutral', 'Interested']
        predicted_emotion = emotions[np.argmax(prediction)]

        return predicted_emotion

    # Combined Analysis
    face_model = load_model(
        face_model_path, weights_path)

    audio_output_path = 'temp_audio.wav'
    video_to_audio(video_path, audio_output_path)

    voice_emotion = analyze_video_emotion(audio_output_path, voice_model)

    cap = cv2.VideoCapture(video_path)
    all_face_emotions = []

    frame_skip_interval = 60
    while cap.isOpened():
        for _ in range(frame_skip_interval):
            ret, frame = cap.read()

        if not ret:
            break

        face_emotion = predict_face_emotion(face_model, frame)
        all_face_emotions.append(face_emotion)

    cap.release()
    cv2.destroyAllWindows()

    average_face_emotion = mode(all_face_emotions)

    # Generate personalized feedback based on detected emotions
    voice_feedback = voice_feedback_dict.get(voice_emotion, "")

    face_feedback = face_feedback_dict.get(average_face_emotion, "")

    overall_feedback = f"Overall, {voice_feedback} {face_feedback}"

    # Choose additional feedback based on the combination of voice and face emotions
    key_combination = f'{voice_emotion.lower()}_{average_face_emotion.capitalize()}'
    additional_suggestion = additional_feedback_dict.get(key_combination, "")

    # Merge suggestions and additional feedback
    suggestions = {
        'voice_emotion': voice_emotion,
        'face_emotion': average_face_emotion,
        'feedback': overall_feedback,
        'additional_feedback': additional_suggestion
    }

    if os.path.exists(audio_output_path):
        os.remove(audio_output_path)

    return suggestions
