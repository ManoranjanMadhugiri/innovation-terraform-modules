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
