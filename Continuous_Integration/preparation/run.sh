#!/usr/bin/env bash

cd "$(dirname "$0")"

LOCAL_TAG=$(date +"%Y-%m-%d")

echo "Running integration tests with tag: $LOCAL_TAG"

export LOCAL_IMAGE_NAME="ride_prediction:$LOCAL_TAG"

test_name=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep "$LOCAL_IMAGE_NAME")


if [ -z "$test_name" ]; then
  echo "❌ Image $LOCAL_IMAGE_NAME not found"
  echo "Building Docker image: $LOCAL_IMAGE_NAME"
  docker build -t "$LOCAL_IMAGE_NAME" .
else
  echo "✅ Image exists: $test_name"
fi

update_env_var() {
  VAR="$1"
  VALUE="$2"
  if grep -q "^${VAR}=" .env; then
    sed -i "s|^${VAR}=.*|${VAR}=${VALUE}|" .env
  else
    echo "${VAR}=${VALUE}" >> .env
  fi
}

# AWS_ACCESS_KEY_ID=$(grep 'aws_access_key_id' ~/.aws/credential/aws.ini | cut -d'=' -f2 | xargs)
# AWS_SECRET_ACCESS_KEY=$(grep 'aws_secret_access_key' ~/.aws/credential/aws.ini | cut -d'=' -f2 | xargs)
AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"
AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"

TEST_RUN=True
RUN_ID=v2
PREDICTIONS_STREAM_NAME=ride_predictions
MODEL_LOCATION=s3://mlops-storage-practice/1/c7e84880ca934f528e173fe44d431772/artifacts/model/

update_env_var AWS_ACCESS_KEY_ID "$AWS_ACCESS_KEY_ID"
update_env_var AWS_SECRET_ACCESS_KEY "$AWS_SECRET_ACCESS_KEY"
update_env_var LOCAL_IMAGE_NAME "$LOCAL_IMAGE_NAME"
update_env_var PREDICTIONS_STREAM_NAME "$PREDICTIONS_STREAM_NAME"
update_env_var RUN_ID "$RUN_ID"
update_env_var TEST_RUN "$TEST_RUN"
update_env_var MODEL_LOCATION "$MODEL_LOCATION"

docker compose up -d
