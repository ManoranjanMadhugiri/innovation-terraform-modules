variable "name" {
  default = ""
}

variable "data_ids" {
  type    = "list"
  default = []
}

variable "type" {
  type    = "list"
  default = ["IPMatch"]
}

variable "negated" {
  default = "false"
}

resource "aws_waf_rule" "wafrule" {
  name        = "${var.name}"
  metric_name = "${var.name}"

  predicates {
    data_id = "${element(var.data_ids, 0)}"
    negated = "${var.negated}"
    type    = "${element(var.type,0)}"
  }

  predicates {
    data_id = "${element(var.data_ids, 1)}"
    negated = "${var.negated}"
    type    = "${element(var.type, 1)}"
  }

  predicates {
    data_id = "${element(var.data_ids, 2)}"
    negated = "${var.negated}"
    type    = "${element(var.type, 2)}"
  }
}

output "aws_waf_rule_id" {
  value = "${aws_waf_rule.wafrule.id}"
}
