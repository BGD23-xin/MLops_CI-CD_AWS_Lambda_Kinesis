variable "ecr_name" {
  description = "Full name of the ECR repository"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "ecr_tag" {
  description = "Tag for the Docker image to push"
  type        = string
  default     = "latest"
}

variable "lambda_function_local_path" {
  description = "Path to the local Lambda function Python file"
  type        = string
}

variable "docker_image_local_path" {
  description = "Path to the Dockerfile used to build the Lambda image"
  type        = string
}

variable "docker_context_path" {
  description = "Directory used as the context when building the Docker image"
  type        = string
}
