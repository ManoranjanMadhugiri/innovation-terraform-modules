variable "env" {
  default = ""
}

variable "private_subnet_ids" {
  type = "list"
}

variable "launch_conf" {
  default = ""
}

variable "target_group_arns" {
  type = "list"
}

variable "min_size" {}

variable "max_size" {}

variable "health_check_type" {
  default = "EC2"
}

variable "name" {}

variable "health_check_grace_period" {
  default = "200"
}

variable "desired_capacity" {
  default = "1"
}
