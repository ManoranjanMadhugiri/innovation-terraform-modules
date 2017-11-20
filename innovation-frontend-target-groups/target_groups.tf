

resource "aws_alb_target_group" "web" {
  name= "${var.name}-${var.env}"
  port     = "${var.target_port}"
  protocol = "${var.target_protocol}"
  vpc_id = "${var.vpc_id}"
  target_type = "${var.target_type}"
  stickiness {
    type            = "lb_cookie"
    cookie_duration = "86400"
    enabled         = "${var.stickiness}"
  }
health_check {
      healthy_threshold = "${var.healthy_threshold}"
      unhealthy_threshold = "${var.unhealthy_threshold}"
      timeout = "${var.timeout}"
      path = "${var.health_check_path}"
	  matcher = "${var.health_check_matcher}"
  }
    tags = "${var.add_tags}"
    lifecycle {
        create_before_destroy = true
    }
}


output "alb_target_arn" {
  value = "${aws_alb_target_group.web.arn}"
}
