variable "AMIS" {
  type = "map"

  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-ac398ed4"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "AWS_REGION" {
  default = "us-west-2"
}

variable "env" {
  default = ""
}

variable "aws_autoscaling_group_name" {
  default = ""
}

variable "security_groups" {
  type = "list"
}

variable "instance_type" {
  default = ""
}

variable "iam_instance_profile" {
  default = "s3_derwent-innovation"
}

variable "service_name" {
  default = ""
}

variable "name" {
  default = ""
}

variable "enable_monitoring" {
  default = ""
}

variable "ebs_optimized" {
  default = ""
}

variable "keyname" {
  default = ""
}

variable "domain_name" {
  default = "dev-innovation.com"
}

variable "dynomite_clusterName" {
  default = ""
}

variable "node_count" {
  default = 1
}
