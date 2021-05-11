import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
from StockList.generatedata import forecastdata
import datetime


def getData(ts_code):
    tom_time = datetime.datetime.now() + datetime.timedelta(days=-1)
    ago_time = datetime.datetime.now() + datetime.timedelta(days=-180)
    ago_str = ago_time.strftime("%Y%m%d")
    tom_str = tom_time.strftime("%Y%m%d")
    x_train, y_train = forecastdata(ts_code, ago_str, tom_str)
    return x_train[::-1], y_train[::-1]


def windowed_dataset(series, window_size, batch_size, shuffle_buffer):
    dataset = tf.data.Dataset.from_tensor_slices(series)
    dataset = dataset.window(window_size + 1, shift=1, drop_remainder=True)
    dataset = dataset.flat_map(lambda window: window.batch(window_size + 1))
    dataset = dataset.shuffle(shuffle_buffer).map(lambda window: (window[:-1], window[-1]))
    # 打包成数组
    dataset = dataset.batch(batch_size)
    return dataset


def forecastmodel(dataset):
    # 搭建SimpleRNN神经网络，使用LR_scheduler机制调整学习率
    # 搭建SimpleRNN神经网络，不调整学习率
    tf.keras.backend.clear_session()
    tf.random.set_seed(51)
    np.random.seed(51)
    model = tf.keras.models.Sequential([
        tf.keras.layers.Lambda(lambda x: tf.expand_dims(x, axis=-1),
                               input_shape=[None]),
        tf.keras.layers.SimpleRNN(40, return_sequences=True),
        tf.keras.layers.SimpleRNN(40),
        tf.keras.layers.Dense(1),
        tf.keras.layers.Lambda(lambda x: x * 100.0)
    ])
    # 在需要将隐层的结果作为下一层的输入时，选择return_sequences=True

    optimizer = tf.keras.optimizers.SGD(lr=5e-7, momentum=0.9)
    model.compile(loss=tf.keras.losses.Huber(),
                  optimizer=optimizer,
                  metrics=["mae"])
    model.fit(dataset, epochs=100, verbose=0)
    return model


def forecastfunc(ts_code):
    x_train, y_train = getData(ts_code)
    window_size = 20
    batch_size = 32
    shuffle_buffer_size = 10

    dataset = windowed_dataset(y_train, window_size, batch_size=batch_size, shuffle_buffer=shuffle_buffer_size)
    resultmodel = forecastmodel(dataset)
    result = resultmodel.predict(y_train[-1-window_size:-1][np.newaxis])
    return result[0][0]
