resource "aws_alb_listener_rule" "innovation-frontend-listener-rule" {
  listener_arn = "${var.listener_arn}"
  priority     = "${var.priority}"

  action {
    type = "${var.action}"

  target_group_arn = "${var.alb_target_arn}"
  }

  condition {
    field  = "path-pattern"
    values =["${var.route_path}"]
  }

}
