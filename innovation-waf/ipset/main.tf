variable "type" {
  default = "IPV4"
}

variable "name" {
  default = ""
}

variable "aws_waf_ipset" {
  type = "list"
}

resource "aws_waf_ipset" "innovation_waf_ipset" {
  name = "${var.name}"

  ip_set_descriptors {
    type  = "${var.type}"
    value = "${element(var.aws_waf_ipset, 0)}"
  }

  ip_set_descriptors {
    type  = "${var.type}"
    value = "${element(var.aws_waf_ipset, 1)}"
  }

  ip_set_descriptors {
    type  = "${var.type}"
    value = "${element(var.aws_waf_ipset,2)}"
  }
}

output "innovation_waf_ipset_id" {
  value = "${aws_waf_ipset.innovation_waf_ipset.id}"
}
