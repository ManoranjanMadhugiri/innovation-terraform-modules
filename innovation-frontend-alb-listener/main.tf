
resource "aws_alb_listener" "listener" {
  load_balancer_arn = "${var.alb_arn}"
  port              = "${var.port}"
  protocol          = "${var.protocol}"
#  ssl_policy        = "${var.ssl_policy}"
#  certificate_arn   = "${aws_iam_server_certificate.certificate.arn}"

  default_action {
    type = "${var.action}"
    target_group_arn = "${var.target_group_arn}"
  }
}
