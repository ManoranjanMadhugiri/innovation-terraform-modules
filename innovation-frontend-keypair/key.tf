variable "private_key" {
  default = "my_key"
}

variable "public_key" {
  default = "my_key.pub"
}

variable "key_name" {
  default = "innovation-key"
}

resource "aws_key_pair" "aws_key_pair" {
  key_name   = "${var.key_name}"
  public_key = "${file("${path.module}/${var.public_key}")}"
}

output "keypair_name" {
  value = "${aws_key_pair.aws_key_pair.key_name}"
}
