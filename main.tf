provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0e35ddab05955cf57" # Replace with your AMI ID
  instance_type = "t2.micro"
  tags = {
    Name = "ExampleInstance"
  }
}

module "start_instance" {
  source              = "./modules/lambda_scheduler"
  lambda_name         = "StartEC2InstanceLambda"
  schedule_expression = "cron(0 8 * * ? *)"
  instance_ids        = [aws_instance.example.id]
  action              = "start"
}

module "stop_instance" {
  source              = "./modules/lambda_scheduler"
  lambda_name         = "StopEC2InstanceLambda"
  schedule_expression = "cron(0 17 * * ? *)"
  instance_ids        = [aws_instance.example.id]
  action              = "stop"
}
