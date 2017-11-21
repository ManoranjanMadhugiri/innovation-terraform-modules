
variable "env" {
  default = ""
}

variable "region"{}

resource "aws_s3_bucket" "inbuck" {
  bucket = "derwent-innovation-${var.region}-${var.env}"
  acl    = "private"
  logging {
     target_bucket = "${aws_s3_bucket.log_bucket.id}"
     target_prefix = "log/"
   }
   versioning {
    enabled = true
  }
  tags {
    Name        = "Innovation-${var.region}-${var.env}"
    Environment = "${var.env}"
  }
}



resource "aws_s3_bucket" "log_bucket" {
  bucket = "innov-log-bucket-${var.region}-${var.env}"
  acl    = "log-delivery-write"
  force_destroy = true
  tags {
    Name        = "Log bucket"
    Environment = "${var.env}"
  }
}
