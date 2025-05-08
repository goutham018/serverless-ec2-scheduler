provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami                         = "ami-0e35ddab05955cf57" # Update as needed per region
  instance_type               = "t2.micro"
  associate_public_ip_address = true

  tags = {
    Name = "EC2-Scheduled-Instance"
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_function"
  output_path = "${path.module}/lambda_function_payload.zip"
}

module "start_instance" {
  source          = "./modules/lambda_scheduler"
  name_prefix     = "start"
  lambda_zip_path = data.archive_file.lambda_zip.output_path
  schedule        = "cron(0 8 * * ? *)" # 8 AM UTC
  instance_ids    = [aws_instance.example.id]
  action          = "start"
}

module "stop_instance" {
  source          = "./modules/lambda_scheduler"
  name_prefix     = "stop"
  lambda_zip_path = data.archive_file.lambda_zip.output_path
  schedule        = "cron(0 17 * * ? *)" # 5 PM UTC
  instance_ids    = [aws_instance.example.id]
  action          = "stop"
}
