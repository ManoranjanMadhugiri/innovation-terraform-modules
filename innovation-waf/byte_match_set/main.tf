variable "name" {
  default = ""
}

variable "text_transformation" {
  type    = "list"
  default = ["NONE"]
}

variable "target_string" {
  type    = "list"
  default = []
}

variable "positional_constraint" {
  type    = "list"
  default = ["CONTAINS"]
}

variable "type" {
  type    = "list"
  default = ["URI"]
}

resource "aws_waf_byte_match_set" "innovation_waf_byte_set" {
  name = "${var.name}"

  byte_match_tuples {
    text_transformation   = "${element(var.text_transformation,0)}"
    target_string         = "${element(var.target_string,0)}"
    positional_constraint = "${element(var.positional_constraint,0)}"

    field_to_match {
      type = "${element(var.type,0)}"
    }
  }
}

output "innovation_waf_byte_set_id" {
  value = "${aws_waf_byte_match_set.innovation_waf_byte_set.id }"
}
