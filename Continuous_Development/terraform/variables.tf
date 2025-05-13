variable "aws_region" {
  description = "AWS region to create resources"
  type        = string
  default     = "eu-west-3"
}

variable "model_storage" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "mlops-storage"
}

variable "project_id" {
  description = "Project ID, used for naming resources"
  type        = string
  default     = "practice"
}

variable "ecr_name" {
  description = "Base name for ECR repository"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "ecr_tag" {
  description = "ECR image tag"
  type        = string
  default     = "latest"
}

variable "lambda_function_local_path" {
  description = "Path to the lambda function Python code file"
  type        = string
}

variable "docker_image_local_path" {
  description = "Path to the Dockerfile"
  type        = string
}

variable "docker_context_path" {
  description = "Directory used as the docker build context"
  type        = string
}

variable "source_stream_name" {
  description = "Name of the source Kinesis stream"
  type        = string
}
variable "output_stream_name" {
  description = "Name of the output Kinesis stream"
  type        = string
}


variable "lambda_function_name" {
  description = ""
  default     = "lambda-kinesis-function"
}
