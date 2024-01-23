from keras.models import Sequential
from keras.layers import Dense, Conv2D, MaxPooling2D, BatchNormalization, Dropout, Flatten
from keras.optimizers import Adamax
from keras.callbacks import EarlyStopping, ReduceLROnPlateau

import tensorflow as tf

import matplotlib.pyplot as plt


train_dir = 'trained'

training = tf.keras.preprocessing.image.ImageDataGenerator(rescale=1/255.0,
                                                           rotation_range=7,
                                                           horizontal_flip=True,
                                                           validation_split=0.2).flow_from_directory(train_dir, batch_size=16,
                                                                                                     target_size=(
                                                                                                         64, 64),
                                                                                                     subset="training",
                                                                                                     )


validing = tf.keras.preprocessing.image.ImageDataGenerator(rescale=1/255.0,
                                                           rotation_range=7,
                                                           horizontal_flip=True,
                                                           validation_split=0.2).flow_from_directory(train_dir, batch_size=16,
                                                                                                     target_size=(
                                                                                                         64, 64),
                                                                                                     subset='validation',
                                                                                                     shuffle=False
                                                                                                     )

optimizers = tf.keras.optimizers.legacy.Adamax(
    learning_rate=0.001, beta_1=0.9, beta_2=0.99, decay=0.001/32)

EarlyStop = EarlyStopping(
    patience=10, restore_best_weights=True, monitor='accuracy')
Reduce_LR = ReduceLROnPlateau(
    monitor='loss', verbose=2, factor=0.5, min_lr=0.00001)
callback = [EarlyStop, Reduce_LR]
num_classes = 3
num_detectors = 32

network = Sequential()

network.add(Conv2D(num_detectors, (3, 3), activation='relu',
            padding='same', input_shape=(64, 64, 3)))
network.add(BatchNormalization())
network.add(Conv2D(num_detectors, (3, 3), activation='relu', padding='same'))
network.add(BatchNormalization())
network.add(MaxPooling2D(pool_size=(2, 2)))
network.add(Dropout(0.2))

network.add(Conv2D(2*num_detectors, (3, 3), activation='relu', padding='same'))
network.add(BatchNormalization())
network.add(Conv2D(2*num_detectors, (3, 3), activation='relu', padding='same'))
network.add(BatchNormalization())
network.add(MaxPooling2D(pool_size=(2, 2)))
network.add(Dropout(0.2))

network.add(Conv2D(2*2*num_detectors, (3, 3),
            activation='relu', padding='same'))
network.add(BatchNormalization())
network.add(Conv2D(2*2*num_detectors, (3, 3),
            activation='relu', padding='same'))
network.add(BatchNormalization())
network.add(MaxPooling2D(pool_size=(2, 2)))
network.add(Dropout(0.2))

network.add(Conv2D(2*2*2*num_detectors, (3, 3),
            activation='relu', padding='same'))
network.add(BatchNormalization())
network.add(Conv2D(2*2*2*num_detectors, (3, 3),
            activation='relu', padding='same'))
network.add(BatchNormalization())
network.add(MaxPooling2D(pool_size=(2, 2)))
network.add(Dropout(0.2))

network.add(Flatten())

network.add(Dense(2 * num_detectors, activation='relu'))
network.add(BatchNormalization())
network.add(Dropout(0.2))

network.add(Dense(2 * num_detectors, activation='relu'))
network.add(BatchNormalization())
network.add(Dropout(0.2))

network.add(Dense(num_classes, activation='softmax'))
network.compile(optimizer=optimizers,
                loss='categorical_crossentropy', metrics=["accuracy"])


history = network.fit(training, validation_data=validing,
                      epochs=20, callbacks=callback, verbose=2)
metrics = history.history
plt.plot(history.epoch, metrics['loss'])
plt.legend(['loss'])
plt.show()


model_json = network.to_json()
with open('network.json', 'w') as json_file:
    json_file.write(model_json)


network.save('Education.h5')
