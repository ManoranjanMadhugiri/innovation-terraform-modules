
resource "aws_launch_configuration" "launchconfig" {
  name_prefix          = "${var.name}-${var.env}"
  image_id             = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name             = "${var.keyname}"
  security_groups      = ["${var.security_groups}"]
  user_data            = "${data.template_file.user_data.rendered}"
  associate_public_ip_address = false
  enable_monitoring = true
  ebs_optimized = false

  root_block_device {
       volume_type           = "gp2"
       volume_size           = 30
       delete_on_termination = true
   }

  lifecycle              { create_before_destroy = true }
}


data "template_file" "user_data" {
  template = "${file("${path.module}/userdata.sh")}"

  vars {
    arguments = "${var.arguments}"
    env = "${var.env}"
  }
}

output "launch_conf" {
  value ="${aws_launch_configuration.launchconfig.name}"
}
