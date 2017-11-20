/**
 * # terraform_aws_security_group
 *
 * Module `terraform_aws_security_group` is a Terraform module to create AWS
 * security groups. However, it also helps manage ICMP rules in the sense
 * that will create, if desired, a policy that denies all ICMP *except* for
 * ICMP type 3, which helps manage path MTU discovery. It also will tag your
 * security group for you, if desired.
 *
 * Usage Example:
 *
 *     module "security_group" {
 *       source       = "github.com/paybyphone/terraform_aws_security_group?ref=VERSION"
 *       vpc_id       = "${var.vpc_id}"
 *       project_path = "your/project"
 *     }
 *
 */

 terraform {
   required_version = ">= 0.10.6"
 }


// The ID of the VPC.
variable "vpc_id" {
  type = "string"
}
// The description field for the Security Group. The default is the built-in Terraform default:
// "Managed by Terraform".
variable "description" {
  type    = "string"
  default = "Managed by Terraform" // Because you can't have a null value
}

// A value for the `Name` tag. If not set, the tag is not created.
variable "display_name" {
  type    = "string"
  default = ""
}

variable "sec_name" {
  default = ""
}

variable "to_ports" {
  type="list"
  default = []
}

variable "from_ports" {
  type="list"
  default = []
}

variable "source_security_groups" {
  type="list"
  default = []
}

variable "protocol"{
  default = "tcp"
}

variable "env" {
  default = ""
}

locals {

  default_tags   = "${map("Created By", "Terraform")}"
  name_tag_key   = "${compact(split(",", length(var.display_name) == 0 ? "" : "Name"))}"
  name_tag_value = "${compact(split(",", length(var.display_name) == 0 ? "" : "${var.display_name}"))}"
}

resource "aws_security_group" "security_group" {
  vpc_id      = "${var.vpc_id}"
  name        = "${var.sec_name}-${var.env}"
  description = "${var.description}"

  tags = "${merge(
    local.default_tags,
    zipmap(local.name_tag_key, local.name_tag_value)
    )}"
}


resource "aws_security_group_rule" "security_group_inbound" {
  count             = "${length(var.from_ports)}"
  type              = "ingress"
  protocol          = "${var.protocol}"
  from_port         = "${element(var.from_ports, count.index)}"
  to_port           =  "${element(var.to_ports, count.index)}"
  source_security_group_id = "${element(var.source_security_groups, "${length(var.source_security_groups) - (count.index + 1) < 0 ? (length(var.source_security_groups)-1) : count.index}")}"
  security_group_id = "${aws_security_group.security_group.id}"
}


resource "aws_security_group_rule" "security_group_outbound" {
  type              = "egress"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  to_port           = 0
  security_group_id = "${aws_security_group.security_group.id}"
}

// The ID of the created security group.
output "security_group_id" {
  value = "${aws_security_group.security_group.id}"
}
