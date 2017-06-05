output "elb_pub_endpoint" {
    value                   = "${aws_elb.elb.dns_name}"
}
