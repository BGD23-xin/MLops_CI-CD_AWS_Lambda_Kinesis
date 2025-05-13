import os

import pandas as pd
import pandas.testing as pdt

import model


def read_text_file(file_path: str):
    """read text file"""
    local_directory = os.path.dirname(os.path.abspath(__file__))
    test_directory = os.path.join(local_directory, file_path)
    with open(test_directory, 'rt', encoding='utf-8') as f_in:
        return f_in.read().strip()


def test_base64_decode():
    """test base64 decode"""
    base64_input = read_text_file('data.b64')

    actual_output = model.base64_decode(base64_input)
    expected_output = {"ride": {"Open": 130, "Volume": 205}, "ride_id": 112}
    assert actual_output == expected_output, f"Expected {expected_output}, but got {actual_output}"


def test_prepare_features():
    """test prepare features"""
    model_service = model.ModelService(None, None, None)
    ride = {
        'Open': 130,
        'Volume': 205,
    }
    actual_features = model_service.prepare_features(ride)

    expected_features = pd.DataFrame(
        [
            {
                'Open': 130,
                'Volume': 205,
            }
        ]
    )

    # 正确比较 DataFrame
    pdt.assert_frame_equal(actual_features, expected_features)


class ModelMock:
    """simulate a model"""

    def __init__(self, fixed_value):
        self.fixed_value = fixed_value

    def predict(self, x):
        """simulate model predict"""
        return [self.fixed_value]  # 模拟模型输出 float 数值


def test_predict():
    """test predict"""
    model_mock = ModelMock(10.0)

    model_service = model.ModelService(model=model_mock, model_version=None, callbacks=None)

    # 模拟特征输入为 DataFrame（符合真实模型输入）
    features = pd.DataFrame(
        [
            {
                "Open": 130,
                "Volume": 205,
            }
        ]
    )

    actual_prediction = model_service.predict(features)
    expected_prediction = 10.0

    assert (
        actual_prediction == expected_prediction
    ), f"Expected {expected_prediction}, got {actual_prediction}"


def test_lambda_handler():
    """test lambda_handler"""
    model_mock = ModelMock(10.0)
    model_version = 'Test123'

    model_service = model.ModelService(
        model=model_mock, model_version=model_version, callbacks=None
    )

    base64_input = read_text_file('data.b64')  # 确保这个文件存在且内容符合 ride_event 格式

    event = {
        "Records": [
            {
                "kinesis": {
                    "data": base64_input,
                },
            }
        ]
    }

    actual_predictions = model_service.lambda_handler(event)

    expected_predictions = {
        'predictions': [
            {
                'model': 'AAPL_Stock_Prediction',  # 注意这里匹配 model.py 中硬编码的名称
                'version': model_version,
                'prediction': {
                    'ride_duration': 10.0,
                    'ride_id': 112,
                },
            }
        ]
    }

    assert (
        actual_predictions == expected_predictions
    ), f"Expected {expected_predictions}, got {actual_predictions}"
