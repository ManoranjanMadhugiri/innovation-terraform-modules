resource "aws_emr_cluster" "emr_cluster" {
  name          = "emr-Themescape-${var.env}"
  release_label = "${var.emr_version}"
  applications  = ["${var.emr_type}"]

  ec2_attributes {
    subnet_id                         = "${var.subnet_id}"
    emr_managed_master_security_group = "${var.emr_managed_master_security_group}"
    emr_managed_slave_security_group  = "${var.emr_managed_slave_security_group}"
    service_access_security_group     = "${var.service_access_security_group}"
    instance_profile                  = "EMR_EC2_DefaultRole"
    key_name                          = "MyDev-Yuvaraj"
  }

  service_role         = "EMR_DefaultRole"
  autoscaling_role     = "EMR_AutoScaling_DefaultRole"
  ebs_root_volume_size = 20
  log_uri              = "s3n://${aws_s3_bucket.emr_log_bucket.id}"

  # master_instance_type = "r3.xlarge"
  visible_to_all_users = true

  tags {
    created_by = "innovation Terraform"
    name       = "emr-Themescape-${var.env}"
  }

  instance_group = [{
    instance_role  = "TASK"
    instance_type  = "r3.xlarge"
    instance_count = "2"
    name           = "task instance group"

    ebs_config {
      size = "1024"
      type = "gp2"
    }

    autoscaling_policy = "${file("${path.module}/Files/autoscalingpolicy.json")}"
  },
    {
      instance_role  = "CORE"
      instance_type  = "r3.xlarge"
      instance_count = "1"
      name           = "core instance group"

      ebs_config {
        size = "1024"
        type = "gp2"
      }

      autoscaling_policy = "${file("${path.module}/Files/autoscalingpolicy.json")}"
    },
    {
      instance_role  = "MASTER"
      instance_type  = "r3.xlarge"
      instance_count = "1"
    },
  ]

  bootstrap_action {
    path = "s3://themescape-emr-us-west-2-prod/bootstrap-actions/bootstrap.sh"
    name = "bootstrap"

    #args = ["tomcat_version=8.5.16"]
  }

  configurations = "${file("${path.module}/Files/configuration.json")}"
}

#s3 bucket to store emr AWSLogs
resource "aws_s3_bucket" "emr_log_bucket" {
  bucket        = "themescape-emr-${var.region}-${var.env}"
  acl           = "public-read-write"
  force_destroy = true

  #   logging {
  #   //target_bucket = "${aws_s3_bucket.emr_log_bucket.id}"
  #   target_prefix = "elasticmapreduce/"
  # }

  tags {
    Name        = "emr Log bucket"
    Environment = "${var.env}"
    created_by  = "innovation-terraform"
  }
}

resource "aws_s3_bucket_policy" "emr_log_bucket_ploicy" {
  bucket = "${aws_s3_bucket.emr_log_bucket.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "MYBUCKETPOLICY",
  "Statement": [
    {
      "Sid": "AWSConsoleStmt-${aws_s3_bucket.emr_log_bucket.id}",
      "Effect": "Allow",
      "Principal": {
       "AWS": "arn:aws:iam::797873946194:root"
       },
      "Action": ["s3:*"],
      "Resource": "${aws_s3_bucket.emr_log_bucket.arn}/AWSLogs/687890756020/*"
    }
  ]
}
EOF
}
