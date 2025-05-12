terraform {
  required_version = ">= 1.0.0"
  backend "s3" {
    bucket         = "my-aws-bucket-3550"
    key            = "goutham/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}
