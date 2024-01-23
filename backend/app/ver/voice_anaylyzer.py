import os
import numpy as np
import joblib
from pydub import AudioSegment
from moviepy.editor import VideoFileClip
import librosa


def video_to_audio(video_path, audio_path):
    # Load the video clip
    video_clip = VideoFileClip(video_path)

    # Extract audio from the video clip
    audio_clip = video_clip.audio

    # Save the audio clip as a WAV file
    audio_clip.write_audiofile(
        audio_path, codec='pcm_s16le', fps=44100)

    # Close the video and audio clips
    video_clip.close()
    audio_clip.close()


def extract_feature(file_name, mfcc=True, chroma=True, mel=True):
    audio = AudioSegment.from_wav(file_name)

    # Normalize the audio data to the range [-1, 1]
    y = np.array(audio.get_array_of_samples()) / 32768.0

    # Extracting features
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

    # Pad the feature vector with zeros to make it consistent
    features = np.pad(features, (0, 180 - len(features)))

    return features


def analyze_video_emotion(video_path, model_path='/Users/nadirazeez/Documents/shermina/comunico/app/ver/model/speech_emotion_model.pkl'):
    # Extract audio from video using moviepy
    audio_output_path = 'temp_audio.wav'
    video_to_audio(video_path, audio_output_path)

    # Load the trained model
    model = joblib.load(model_path)

    # Extract features from the audio
    features = extract_feature(
        audio_output_path, mfcc=True, chroma=True, mel=True)

    # Reshape features to match the model input shape
    features = features.reshape(1, -1)

    # Predict emotion
    predicted_emotion = model.predict(features)[0]

    return predicted_emotion


# Example usage
video_file_path = '/Users/nadirazeez/Documents/shermina/comunico/app/demo/voices/emot1.mp4'
predicted_emotion = analyze_video_emotion(video_file_path)
print(f'Predicted Emotion: {predicted_emotion}')

# Clean up temporary audio file
if os.path.exists('temp_audio.wav'):
    os.remove('temp_audio.wav')
