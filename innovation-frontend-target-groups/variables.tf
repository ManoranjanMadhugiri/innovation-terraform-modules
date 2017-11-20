# Target group parameters

variable "name" {
  default = ""
  description = "The target group name prefix."
}

variable "vpc_id" {
  default = ""
  description = "The identifier of the virtual private cloud (VPC) for the target group."
}

variable "target_port" {
  default = 80
  description = "The port the load balancer uses when routing traffic to targets in this target group (1-65535)."
}

variable "target_protocol" {
  default = "HTTP"
  description = "The protocol the load balancer uses when routing traffic to targets in this target group."
}


variable "health_check_matcher" {
  default = "200"
  description = "The HTTP codes to use when checking for a successful response from a target."
}

variable "stickiness" {
  default = true
  description = "Boolean to enable / disable stickiness"
}

variable "add_tags" {
  type = "map"
  default = {}
}

variable "health_check_path" {
  default = ""
}

variable "target_type"{
  default = "instance"
}

variable "deregistration_delay" {
  default = "10"
}

variable "healthy_threshold" {
  default = "3"
}

variable "unhealthy_threshold" {
  default = "2"
}

variable "timeout" {
  default = "5"
}

variable "env"{}
