import cv2
import os
from tqdm import tqdm  # For progress bars


def preprocess_images(input_dir, output_dir, target_size=(48, 48)):
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    for emotion_folder in os.listdir(input_dir):
        emotion_path = os.path.join(input_dir, emotion_folder)
        output_emotion_path = os.path.join(output_dir, emotion_folder)

        if not os.path.exists(output_emotion_path):
            os.makedirs(output_emotion_path)

        for img_name in tqdm(os.listdir(emotion_path), desc=emotion_folder):
            img_path = os.path.join(emotion_path, img_name)
            img = cv2.imread(img_path, cv2.IMREAD_GRAYSCALE)
            img = cv2.resize(img, target_size)
            img = img / 255.0  # Normalize pixel values
            output_path = os.path.join(output_emotion_path, img_name)
            cv2.imwrite(output_path, img)


# Preprocess train, test, and val sets
preprocess_images('/Users/nadirazeez/Documents/shermina/comunico/fer/train',
                  'trained')
