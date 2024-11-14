import os
import tensorflow as tf

# Nonaktifkan log peringatan
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'

model = tf.keras.Sequential([
    tf.keras.layers.Conv2D(32, (3, 3), activation='relu', input_shape=(224, 224, 3)),
    tf.keras.layers.MaxPooling2D(pool_size=(2, 2)),
    tf.keras.layers.Flatten(),
    tf.keras.layers.Dense(64, activation='relu'),
    tf.keras.layers.Dense(10, activation='softmax')
])

# Mendefinisikan spesifikasi input
input_shape = (1, 224, 224, 3)  
tf_input = tf.TensorSpec(shape=input_shape, dtype=tf.float32)

converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()