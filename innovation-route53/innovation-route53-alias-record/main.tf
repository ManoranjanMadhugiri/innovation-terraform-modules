variable "zone_id" {
  type = "list"
}

variable "name" {
  default = ""
}

variable "type" {
  default = ""
}

variable "alias_name" {
  default = ""
}

variable "alias_zone_id" {
  default = ""
}

resource "aws_route53_record" "innovation_route53_alis_record" {
  count   = "${length(var.zone_id)}"
  zone_id = "${element(var.zone_id,count.index)}"
  name    = "${var.name}"
  type    = "${var.type}"

  alias {
    name                   = "${var.alias_name}"
    zone_id                = "${var.alias_zone_id}"
    evaluate_target_health = true
  }
}
