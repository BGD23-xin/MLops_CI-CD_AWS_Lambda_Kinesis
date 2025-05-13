# resource "aws_s3_bucket" "tf_state_bucket" {
#   bucket = var.backend_bucket
#   force_destroy = true
#   tags = {
#     Name        = "Terraform State Bucket"
#     Environment = "stg"
#   }
# }
