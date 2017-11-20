# alb-listener #

This module incapsulates creation of ALB target group with correspondent listeners and rules.

## Input parameters ##

* `name_prefix`      - Name prefix for the new target group. The full name will be appended with
                     `target_port` number.

* `target_group_arn` - (Optional) The Amazon Resource Name (ARN) of the target group.
                     If not setted new target group with `target_protocol`
                     and `target_port` will be created.

* `vpc_id`           - (Optional if `target_group_arn` is setted) The identifier of the virtual
                     private cloud (VPC) for the target group.

* `target_port`      - (Optional. Default the same as the listener `port`) The port the load balancer
                     uses when routing traffic to targets in this target group (1-65535).

* `target_protocol`  - (Optional. Default the same as the listener `protocol`) The protocol
                     the load balancer uses when routing traffic to targets in this target group.

* `health_check_matcher` - (Optional. Default is "200") The HTTP codes to use when checking for
                     a successful response from a target.

* `stickiness`       - (Optional.  Default is _false_) Enable/disable session stickiness.
                     If enabled during 1 day (86400 seconds) all requests from a client
                     will be routed to the same target.

* `add_tags`         - (Optional if `target_group_arn` is setted) Target group tags.

* `alb_arn`          - The Amazon Resource Name (ARN) of the load balancer.

* `port`             - The port on which the load balancer is listening.

* `protocol`         - (Optional. Default is "HTTP") The protocol for connections from clients
                     to the load balancer.

* `action`           - (Optional. Default is "forward") The listener default action.

* `ssl_policy`       - The name of the SSL Policy for the listener. Required if protocol is HTTPS.

* `certificate_arn`  - The ARN of the SSL server certificate.

## Output value ##

* `alb_target_arn`   - The Amazon Resource Name (ARN) of the newly created target group.

## Examples ##

1. Create new target group and listener

``` hcl
module "cortellis_middleware-b_listener_9630" {
  source      = "git::git@github.com:ThomsonReuters-IPS/cortellis-terraform-modules.git//alb-listener?ref=v0.0.1"
  name_prefix = "cortellis-middleware-b-alb-tg-"
  port        = 9630
  alb_arn     = "${aws_alb.cortellis_rs.arn}"
  vpc_id      = "${data.terraform_remote_state.network.vpc_dev_us-west-2_bridge}"

  health_check_matcher = "200,404"

  add_tags = "${merge(var.default_tags,
      map("Name", "cortellis_middleware-b_alb_target-group"),
      map("ca:tag-date", "2017-03-09T09:26:08Z"))}"
}
```

2. Add newly created target to the autoscaling group

``` hcl
resource "aws_autoscaling_group" "cortellis_middleware-b" {
  ...
  target_group_arns = [
    ...
    "${module.cortellis_middleware-b_listener_9630.alb_target_arn}",
    ...
  ]
  ...
}
```

3. Create SSL listener and attach it to the existent target group

``` hcl
module "cortellis_apitools_lb_443" {
  source           = "git::git@github.com:ThomsonReuters-IPS/cortellis-terraform-modules.git//alb-listener?ref=v0.0.1"
  port             = 443
  protocol         = "HTTPS"
  ssl_policy       = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn  = "arn:aws:acm:us-west-2:308797447181:certificate/d6db92ee-3ad3-4376-9713-d7a66dee1f0a"

  alb_arn          = "${aws_alb.cortellis_apitools.arn}"
  target_group_arn = "${aws_alb_target_group.cortellis_frontend_target_18082.arn}"
}
```
