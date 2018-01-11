variable "env" {
  default = ""
}

variable "security_groups" {
  type = "list"
}

variable "public_subnet_ids" {
  type = "list"
}

variable "name" {
  default = ""
}

variable "idle_timeout" {
  default     = "60"
  description = "The time in seconds that the connection is allowed to be idle"
}

variable "enable_deletion_protection" {
  default     = "false"
  description = "If true, deletion of the load balancer will be disabled via the AWS API"
}

variable "region" {
  default = ""
}

variable "default_tags" {
  type = "map"
}

# Application Load Balancer
resource "aws_alb" "alb" {
  name_prefix                = "${var.name}"
  internal                   = false
  security_groups            = ["${var.security_groups}"]
  subnets                    = ["${var.public_subnet_ids}"]
  idle_timeout               = "${var.idle_timeout}"
  enable_deletion_protection = "${var.enable_deletion_protection}"

  access_logs {
    bucket  = "di-alb-${var.region}-${var.env}"
    enabled = true
    prefix  = ""
  }

  tags = "${merge(var.default_tags, map("env","${var.env}"))}"
}

output "alb_arn" {
  value = "${aws_alb.alb.arn}"
}

output "alb_dns_name" {
  value = "${aws_alb.alb.dns_name}"
}
