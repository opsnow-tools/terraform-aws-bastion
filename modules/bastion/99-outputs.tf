// Output some useful variables for quick SSH access etc.

output "name" {
  value = "${local.upper_name}"
}

output "key_name" {
  value = "${aws_instance.default.key_name}"
}

output "domain" {
  value = "${element(concat(aws_route53_record.default.*.name, list("")), 0)}"
}

output "public_ip" {
  value = "${aws_eip.default.public_ip}"
}
