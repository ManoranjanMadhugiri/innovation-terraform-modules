variable "env" {
  default = ""
}

variable "region" {}

resource "aws_s3_bucket" "inbuck" {
  bucket        = "derwent-innovation-${var.region}-${var.env}"
  acl           = "private"
  force_destroy = true

  logging {
    target_bucket = "innov-log-bucket-${var.region}-${var.env}"
    target_prefix = "log/"
  }

  versioning {
    enabled = true
  }

  tags {
    Name        = "Innovation-${var.region}-${var.env}"
    Environment = "${var.env}"
    created_by  = "innovation-terraform"
  }
}

resource "aws_s3_bucket" "log_bucket" {
  bucket        = "innov-log-bucket-${var.region}-${var.env}"
  acl           = "log-delivery-write"
  force_destroy = true

  tags {
    Name        = "Log bucket"
    Environment = "${var.env}"
    created_by  = "innovation-terraform"
  }
}

# s3 bucket to store alb logs
resource "aws_s3_bucket" "alb_log_bucket" {
  bucket        = "di-alb-${var.region}-${var.env}"
  acl           = "log-delivery-write"
  force_destroy = true

  tags {
    Name        = "alb Log bucket"
    Environment = "${var.env}"
    created_by  = "innovation-terraform"
  }
}
