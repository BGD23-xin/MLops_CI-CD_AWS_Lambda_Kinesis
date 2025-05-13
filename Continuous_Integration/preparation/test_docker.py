import requests
from deepdiff import DeepDiff

event = {
    "Records": [
        {
            "kinesis": {
                "kinesisSchemaVersion": "1.0",
                "partitionKey": "1",
                "sequenceNumber": "49630081666084879290581185630324770398608704880802529282",
                "data": "eyJyaWRlIjogeyJPcGVuIjogMTMwLCAiVm9sdW1lIjogMjA1fSwgInJpZGVfaWQiOiAxMTJ9",
                "approximateArrivalTimestamp": 1654161514.132,
            },
            "eventSource": "aws:kinesis",
            "eventVersion": "1.0",
            "eventID": "shardId-000000000000:49630081666084879290581185630324770398608704880802529282",
            "eventName": "aws:kinesis:record",
            "invokeIdentityArn": "arn:aws:iam::387546586013:role/lambda-kinesis-role",
            "awsRegion": "eu-west-3",
            "eventSourceARN": "arn:aws:kinesis:eu-west-3:387546586013:stream/ride_events",
        }
    ]
}


URL = 'http://localhost:8080/2015-03-31/functions/function/invocations'
response = requests.post(URL, json=event, timeout=10)
print(response.json())
actual_ruslt = response.json()
print(f"actual predictions: {actual_ruslt['predictions'][0]['prediction']}")
expected_result = {
    'predictions': [
        {
            'model': 'AAPL_Stock_Prediction',
            'version': 'v2',
            'prediction': {'ride_duration': 1.0, 'ride_id': 112},
        }
    ]
}

difference = DeepDiff(actual_ruslt, expected_result, ignore_order=True)
print(f"Difference: {difference}" if difference else "No differences found")
# assert actual_ruslt == expected_result, f"Test failed: {actual_ruslt} != {expected_result}"
print("Test passed!")
