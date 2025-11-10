variable "aws_profile" {
  type    = string
  default = "sandbox-sso"
}

variable "region" {
  type    = string
  default = "eu-west-3"
}

variable "project" {
  type    = string
  default = "k8s-sbx"
}

variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.20.1.0/24"
}

variable "ssh_cidr" {
  type        = string
  description = "Optional override. If empty, auto-detect public IP."
  default     = ""
}

variable "allow_api_6443" {
  type    = bool
  default = true
}

variable "allow_nodeport" {
  type    = bool
  default = true
}

variable "key_name" {
  type    = string
  default = "sandbox"
}

variable "instance_type_leader" {
  type    = string
  default = "t3.medium"
}

variable "instance_type_worker" {
  type    = string
  default = "t3.medium"
}

variable "worker_count" {
  type    = number
  default = 2
}