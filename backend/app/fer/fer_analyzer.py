from keras.models import model_from_json
import numpy as np
import cv2
from statistics import mode
import matplotlib.pyplot as plt


def load_model(model_path='/Users/nadirazeez/Documents/shermina/comunico/app/fer/model/network.json', weights_path='/Users/nadirazeez/Documents/shermina/comunico/app/fer/model/Education.h5'):
    # Load the model architecture from JSON file
    with open(model_path, 'r') as json_file:
        loaded_model_json = json_file.read()
        loaded_model = model_from_json(loaded_model_json)

    # Load the model weights
    loaded_model.load_weights(weights_path)

    return loaded_model


def preprocess_frame(frame, target_size=(64, 64)):
    # Resize and preprocess the frame
    frame = cv2.resize(frame, target_size)
    frame_array = np.array(frame) / 255.0
    frame_array = np.expand_dims(frame_array, axis=0)  # Add batch dimension
    return frame_array


def predict_emotion(model, frame):
    # Preprocess the frame
    processed_frame = preprocess_frame(frame)

    # Make a prediction
    prediction = model.predict(processed_frame)

    # Get the predicted emotion
    emotions = ['Disappointed', 'Neutral', 'Interested']
    predicted_emotion = emotions[np.argmax(prediction)]

    return predicted_emotion


# Example usage for faster video analysis
loaded_model = load_model()

video_path_to_analyze = '/Users/nadirazeez/Documents/shermina/comunico/app/demo/male/intrested.MOV'
cap = cv2.VideoCapture(video_path_to_analyze)

all_emotions = []

# Set the frame skip interval (adjust as needed)
frame_skip_interval = 10

while cap.isOpened():
    # Skip frames
    for _ in range(frame_skip_interval):
        ret, frame = cap.read()

    if not ret:
        break

    # Analyze the emotion for each frame
    predicted_emotion = predict_emotion(loaded_model, frame)
    all_emotions.append(predicted_emotion)

    # Display the result or save it to a file, etc.
    print(f'Predicted Emotion: {predicted_emotion}')

cap.release()
cv2.destroyAllWindows()
# Calculate the most frequent (mode) emotion
average_emotion = mode(all_emotions)
print(f'Average Emotion: {average_emotion}')


# Plot the distribution of emotions
unique_emotions, counts = np.unique(all_emotions, return_counts=True)

plt.bar(unique_emotions, counts)
plt.title('Emotion Distribution in Video Frames')
plt.xlabel('Emotion')
plt.ylabel('Count')
plt.show()
