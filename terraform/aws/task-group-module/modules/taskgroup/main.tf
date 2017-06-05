# Create a subnet for this task group
resource "aws_subnet" "sn" {
    vpc_id                      = "${var.tg_vpc_id}"
    cidr_block                  = "${var.tg_subnet_cidr}"

    tags {
        Name                    = "sn-${var.tg_name}"
    }
}

# Create an ELB
resource "aws_elb" "elb" {
    name                        = "elb-${var.tg_name}"
    subnets                     = ["${aws_subnet.sn.id}"]
    cross_zone_load_balancing   = true
    connection_draining         = true
    security_groups             = ["${aws_security_group.sg.id}"]

    listener {
        instance_port           = "${var.tg_port}"
        instance_protocol       = "${var.tg_proto}"
        lb_port                 = "${var.tg_port}"
        lb_protocol             = "${var.tg_proto}"
    }

    tags {
        Name                    = "elb-${var.tg_name}"
    }
}

# Create a security group for this task group
resource "aws_security_group" "sg" {
    name                        = "secgrp-${var.tg_name}"
    description                 = "Security group for ${var.tg_name}"
}

# Create an inbound security group rule for this task group
resource "aws_security_group_rule" "sgr-inbound" {
    type                        = "ingress"
    from_port                   = "${var.tg_port}"
    to_port                     = "${var.tg_port}"
    protocol                    = "${var.tg_proto}"
    cidr_blocks                 = ["0.0.0.0/0"]
    security_group_id           = "${aws_security_group.sg.id}"
}

# Allow all outbound for this task group
resource "aws_security_group_rule" "sgr-outbound" {
    type                        = "egress"
    from_port                   = "0"
    to_port                     = "0"
    protocol                    = "-1"
    cidr_blocks                 = ["0.0.0.0/0"]
    security_group_id           = "${aws_security_group.sg.id}"
}

# Create a launch configuration
resource "aws_launch_configuration" "lc" {
    name                        = "lc-${var.tg_name}"
    image_id                    = "${var.tg_ami_id}"
    instance_type               = "${var.tg_type}"
    security_groups             = ["${aws_security_group.sg.id}"]
    key_name                    = "${var.tg_keyname}"

    lifecycle {
        create_before_destroy   = true
    }
}

# Create a placement group
resource "aws_placement_group" "pg" {
    name                        = "pg-${var.tg_name}"
    strategy                    = "cluster"
}

# Create an Auto Scaling group
resource "aws_autoscaling_group" "asg" {
    depends_on                  = ["aws_launch_configuration.lc"]
    name                        = "asg-${var.tg_name}"
    availability_zones          = ["${aws_subnet.sn.availability_zone}"]
    min_size                    = "${var.tg_min_size}"
    max_size                    = "${var.tg_max_size}"
    desired_capacity            = "${var.tg_capacity}"
    placement_group             = "${aws_placement_group.pg.id}"
    launch_configuration        = "${aws_launch_configuration.lc.name}"
    load_balancers              = ["${aws_elb.elb.name}"]

    lifecycle {
        create_before_destroy   = true
    }
}
