variable "name" {
  default = ""
}

variable "default_action_type" {
  default = "BLOCK"
}

variable "rule_action_type" {
  default = "ALLOW"
}

variable "priority" {
  type    = "list"
  default = []
}

variable "rule_ids" {
  type    = "list"
  default = []
}
