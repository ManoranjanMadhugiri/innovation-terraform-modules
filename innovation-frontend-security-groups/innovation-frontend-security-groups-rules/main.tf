variable "to_ports" {
  type    = "list"
  default = []
}

variable "from_ports" {
  type    = "list"
  default = []
}

variable "source_security_groups" {
  type    = "list"
  default = []
}

variable "protocol" {
  default = "tcp"
}

variable "security_group_id" {
  default = ""
}

variable "description" {
  default = ""
}

resource "aws_security_group_rule" "security_group_inbound" {
  count                    = "${length(var.from_ports)}"
  type                     = "ingress"
  protocol                 = "${var.protocol}"
  from_port                = "${element(var.from_ports, count.index)}"
  to_port                  = "${element(var.to_ports, count.index)}"
  source_security_group_id = "${element(var.source_security_groups,count.index)}"
  security_group_id        = "${var.security_group_id}"
  description              = "${var.description}"
}

resource "aws_security_group_rule" "security_group_outbound" {
  type              = "egress"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  security_group_id = "${var.security_group_id}"
}
