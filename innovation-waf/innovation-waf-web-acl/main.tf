resource "aws_waf_web_acl" "waf_acl" {
  name        = "${var.name}"
  metric_name = "${var.name}"

  default_action {
    type = "${var.default_action_type}"
  }

  rules {
    action {
      type = "${var.rule_action_type}"
    }

    priority = "${element(var.priority,0)}"
    rule_id  = "${element(var.rule_ids,0)}"
    type     = "REGULAR"
  }

  rules {
    action {
      type = "${var.rule_action_type}"
    }

    priority = "${element(var.priority,1)}"
    rule_id  = "${element(var.rule_ids,1)}"
    type     = "REGULAR"
  }

  rules {
    action {
      type = "${var.rule_action_type}"
    }

    priority = "${element(var.priority,2)}"
    rule_id  = "${element(var.rule_ids,2)}"
    type     = "REGULAR"
  }

  rules {
    action {
      type = "${var.rule_action_type}"
    }

    priority = "${element(var.priority,3)}"
    rule_id  = "${element(var.rule_ids,3)}"
    type     = "REGULAR"
  }
}
