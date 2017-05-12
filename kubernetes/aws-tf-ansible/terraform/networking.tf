# Create a new VPC
resource "aws_vpc" "k8s_vpc" {
    cidr_block              = "${var.vpc_cidr}"
    enable_dns_hostnames    = "true"
    enable_dns_support      = "true"
    tags {
        tool                = "terraform"
        demo                = "k8s-aws"
        area                = "networking"
    }
}

# Create a public subnet in the new VPC
resource "aws_subnet" "k8s_subnet" {
    vpc_id                  = "${aws_vpc.k8s_vpc.id}"
    cidr_block              = "${var.vpc_cidr}"
    map_public_ip_on_launch = "true"
    tags {
        tool                = "terraform"
        demo                = "k8s-aws"
        area                = "networking"
    }
}

# Create a new Internet gateway
resource "aws_internet_gateway" "k8s_gw" {
    vpc_id                  = "${aws_vpc.k8s_vpc.id}"
    tags {
        tool                = "terraform"
        demo                = "k8s-aws"
        area                = "networking"
    }
}

# Create a route table for the new VPC
resource "aws_route_table" "k8s_rte_tbl" {
    vpc_id                  = "${aws_vpc.k8s_vpc.id}"
    route {
        cidr_block          = "0.0.0.0/0"
        gateway_id          = "${aws_internet_gateway.k8s_gw.id}"
    }
    tags {
        tool                = "terraform"
        demo                = "k8s-aws"
        area                = "networking"
    }
}

# Associate route table with subnet in VPC
resource "aws_route_table_association" "k8s_rta" {
    subnet_id               = "${aws_subnet.k8s_subnet.id}"
    route_table_id          = "${aws_route_table.k8s_rte_tbl.id}"
}

# Create an ELB for Kubernetes API calls
resource "aws_elb" "k8s_api_elb" {
    name                    = "k8s-elb"
    instances               = [ "${aws_instance.controllers.*.id}" ]
    subnets                 = [ "${aws_subnet.k8s_subnet.id}" ]
    cross_zone_load_balancing = false
    security_groups         = [ "${aws_security_group.k8s_api_sg.id}" ]
    listener {
        lb_port             = 6443
        instance_port       = 6443
        lb_protocol         = "tcp"
        instance_protocol   = "tcp"
    }
    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 15
        interval            = 30
        target              = "HTTP:8080/healthz"
    }
    tags {
        Name                = "k8s_elb"
        tool                = "terraform"
        demo                = "k8s-aws"
        area                = "networking"
    }
}

output "kubernetes_api_dns_name" {
    value = "${aws_elb.k8s_api_elb.dns_name}"
}
