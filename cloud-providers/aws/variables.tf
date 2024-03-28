variable "aws_access_key_id" {
  type        = string
  description = "AWS access key used to create infrastructure"
}
variable "aws_secret_access_key" {
  type        = string
  description = "AWS secret key used to create AWS infrastructure"
}
variable "aws_region" {
  type        = string
  description = "AWS region used for all resources"
  default     = "us-east-1"
}
variable "prefix" {
  type        = string
  description = "Prefix added to names of all resources"
  default     = "mak3r"
}

variable "instance_type" {
  type = string
  description = "The aws model name for the k3s host instances"
  default = "db.t2.micro"
}
