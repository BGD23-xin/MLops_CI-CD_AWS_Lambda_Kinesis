terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "5.94.1"
        }
    }
    backend"s3" {
      bucket = "tf-state-mlops-test"
      key     = "mlops-test-stg.tfstate"
      region  = "eu-west-3"
      encrypt = true
    }

}

provider "aws" {
    region = var.aws_region
}

###get the current account id
data "aws_caller_identity" "current_identity" {}

locals {
  account_id = data.aws_caller_identity.current_identity.account_id
}


### Create S3 bucket for model storage
# module "s3" {
#   source = "./modules/s3"
#   bucket_name = "${var.model_storage}-${var.project_id}"
# }

# ################################################
# ### Create ECR repository for model storage  ###
# ################################################
# module "ecr_image" {
#   source                     = "./modules/ecr"
#   ecr_name                   = "${var.ecr_name}_${var.project_id}"
#   account_id                 = var.account_id
#   aws_region                 = var.aws_region                     # ✅ 匹配变量名
#   ecr_tag                    = var.ecr_tag
#   lambda_function_local_path = var.lambda_function_local_path
#   docker_image_local_path    = var.docker_image_local_path
#   docker_context_path        = var.docker_context_path            # ✅ 必须添加
# }



# ################################################
# ###               Create kinesi              ###
# ################################################
# module "source_kinesis_stream" {
#   source = "./modules/kinesis"
#   retention_period = 48
#   shard_count = 1
#   stream_name = "${var.source_stream_name}-${var.project_id}"
#   tags = var.project_id
# }

# module "output_kinesis_stream" {
#   source = "./modules/kinesis"
#   retention_period = 48
#   shard_count = 2
#   stream_name = "${var.output_stream_name}"
#   tags = var.project_id
# }


# ################################################
# ### Create lambda function for model storage  ###
# ################################################
# module "lambda_function" {
#   source = "./modules/lambda"
#   image_uri = module.ecr_image.image_uri
#   lambda_function_name = "${var.lambda_function_name}_${var.project_id}"
#   model_bucket = module.s3.name
#   output_stream_name = "${var.output_stream_name}"
#   output_stream_arn = module.output_kinesis_stream.stream_arn
#   source_stream_name = "${var.source_stream_name}-${var.project_id}"
#   source_stream_arn = module.source_kinesis_stream.stream_arn
# }

#this is for CI/CD
# output "lambda_function" {
#   value     = "${var.lambda_function_name}_${var.project_id}"
# }

# output "model_bucket" {
#   value = module.s3.name
# }

# output "predictions_stream_name" {
#   value     = "${var.output_stream_name}-${var.project_id}"
# }

# output "ecr_repo" {
#   value = "${var.ecr_name}_${var.project_id}"
# }
