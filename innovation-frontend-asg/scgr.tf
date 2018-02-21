resource "aws_autoscaling_group" "innov-autoscaling" {
  name_prefix               = "${var.name}-"
  vpc_zone_identifier       = ["${var.private_subnet_ids}"]
  launch_configuration      = "${var.launch_conf}"
  min_size                  = "${var.min_size}"
  max_size                  = "${var.max_size}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  force_delete              = false
  desired_capacity          = "${var.desired_capacity}"
  target_group_arns         = ["${var.target_group_arns}"]

  tags = ["${concat(
                  list(
                        map("key", "Name", "value",var.name,"propagate_at_launch",true),
                        map("key", "created_by", "value", "innovation-terraform" ,"propagate_at_launch",true)
                  ),
    var.extra_tags)}"]

  # tag {
  #   key                 = "Name"
  #   value               = "${var.name}"
  #   propagate_at_launch = true
  # }
  #
  # tag {
  #   key                 = "created_by"
  #   value               = "innovation-terraform"
  #   propagate_at_launch = true
  # }
  #
  # tag {
  #   key                 = "serviceGroup"
  #   value               = "${var.env:var.name}"
  #   propagate_at_launch = true
  # }
}

output "aws_autoscaling_group_name" {
  value = "aws_autoscaling_group.innov-autoscaling.name"
}
