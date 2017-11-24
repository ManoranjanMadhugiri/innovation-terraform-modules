resource "aws_autoscaling_group" "innov-autoscaling" {
  name          = "${var.name}"
  vpc_zone_identifier  =["${var.private_subnet_ids}"]
  launch_configuration = "${var.launch_conf}"
  min_size             = "${var.min_size}"
  max_size             = "${var.max_size}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type = "${var.health_check_type}"
  force_delete = false
  desired_capacity = "${var.desired_capacity}"
  target_group_arns = ["${var.target_group_arns}"]


  tag {
      key = "Name"
      value = "${var.env}-ec2_instance"
      propagate_at_launch = true
  }
}


output "aws_autoscaling_group_name"{
  value="aws_autoscaling_group.innov-autoscaling.name"
}
