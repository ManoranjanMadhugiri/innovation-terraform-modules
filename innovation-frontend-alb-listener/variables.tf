variable "target_group_arn" {
  default     = ""
  description = "The Amazon Resource Name (ARN) of the target group."
}

# Listener parameters

variable "alb_arn" {
  description = "The ARN of the load balancer."
}

variable "port" {
  default     = 80
  description = "The port on which the load balancer is listening."
}

variable "protocol" {
  default     = "HTTP"
  description = "The protocol for connections from clients to the load balancer."
}

variable "action" {
  default     = "forward"
  description = "The listener default action."
}

variable "ssl_policy" {
  default     = ""
  description = "The name of the SSL Policy for the listener. Required if protocol is HTTPS."
}

variable "certificate_arn" {
  default     = ""
  description = "The ARN of the SSL server certificate."
}

variable "route_path" {
  default     = []
  description = "The route path to the provided URL."
}

variable "priority" {
  default     = ""
  description = "The route path to the provided URL."
}
