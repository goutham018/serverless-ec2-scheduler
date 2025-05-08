variable "lambda_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "schedule_expression" {
  description = "CloudWatch schedule expression"
  type        = string
}

variable "instance_ids" {
  description = "List of EC2 Instance IDs"
  type        = list(string)
}

variable "action" {
  description = "Action to perform: start or stop"
  type        = string
}
