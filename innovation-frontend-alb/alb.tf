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

variable "idle_timeout"{
  default="60"
  description = "The time in seconds that the connection is allowed to be idle"
}

variable "enable_deletion_protection" {
  default = "false"
  description = "If true, deletion of the load balancer will be disabled via the AWS API"
}
# Application Load Balancer
resource "aws_alb" "alb" {
  name_prefix     = "${var.name}-${var.env}"
  internal        = false
  security_groups = ["${var.security_groups}"]
  subnets         = ["${var.public_subnet_ids}"]
  idle_timeout    = "${var.idle_timeout}"
  enable_deletion_protection = "${var.enable_deletion_protection}"

  access_logs {
    bucket  = "di-alb"
    enabled = true
    prefix  = ""
  }
}

output "alb_arn" {
  value = "${aws_alb.alb.arn}"
}
