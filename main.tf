provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Replace with your AMI ID
  instance_type = "t2.micro"
  tags = {
    Name = "ExampleInstance"
  }
}

module "start_instance" {
  source              = "./lambda_function_payload"
  lambda_name         = "StartEC2InstanceLambda"
  schedule_expression = "cron(30 2 * * ? *)" # 8:00 AM IST (2:30 UTC)
  instance_ids        = [aws_instance.example.id]
  action              = "start"
}

module "stop_instance" {
  source              = "./lambda_function_payload"
  lambda_name         = "StopEC2InstanceLambda"
  schedule_expression = "cron(30 11 * * ? *)" # 5:00 PM IST (11:30 UTC)
  instance_ids        = [aws_instance.example.id]
  action              = "stop"
}
