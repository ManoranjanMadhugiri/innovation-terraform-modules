

variable "action" {
  default     = "forward"
  description = "The listener default action."
}


variable "route_path"{
default     = []
description = "The route path to the provided URL."
}


variable "priority"{
default     = ""
description = "The route path to the provided URL."
}

variable "listener_arn" {
  default = ""
}

variable "alb_target_arn" {
  default = ""
}
