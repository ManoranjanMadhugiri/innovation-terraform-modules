variable "zone_id" {
  type    = "list"
  default = []
}

variable "name" {
  default = ""
}

variable "type" {
  default = ""
}

variable "ttl" {
  default = "300"
}

variable "records" {
  type    = "list"
  default = []
}

resource "aws_route53_record" "innovation_route53_record" {
  count   = "${length(var.zone_id)}"
  zone_id = "${element(var.zone_id,count.index)}"
  name    = "${var.name}"
  type    = "${var.type}"
  ttl     = "${var.ttl}"
  records = ["${var.records}"]
}
