# Create a security group to allow traffic to Kubernetes cluster
resource "aws_security_group" "k8s_sg" {
    vpc_id                  = "${aws_vpc.k8s_vpc.id}"
    name                    = "k8s-security-group"
    description             = "Security group for Kubernetes demo"
    ingress {
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["${aws_vpc.k8s_vpc.cidr_block}"]
    }
    ingress {
        from_port           = 22
        to_port             = 22
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    ingress {
        from_port           = 2379
        to_port             = 2379
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    ingress {
        from_port           = 2380
        to_port             = 2380
        protocol            = "tcp"
        cidr_blocks         = ["${aws_vpc.k8s_vpc.cidr_block}"]
    }
    ingress {
        from_port           = 8080
        to_port             = 8080
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    ingress {
        from_port           = 8888
        to_port             = 8888
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    egress {
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    tags {
        tool                = "terraform"
        demo                = "k8s-aws"
        area                = "security"
    }
}

# Create a security group to allow Kubernetes API traffic
resource "aws_security_group" "k8s_api_sg" {
    vpc_id                  = "${aws_vpc.k8s_vpc.id}"
    name                    = "k8s-api-security-group"
    description             = "Security group for Kubernetes demo"
    ingress {
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["${aws_vpc.k8s_vpc.cidr_block}"]
    }
    ingress {
        from_port           = 6443
        to_port             = 6443
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    egress {
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"]
    }
    tags {
        tool                = "terraform"
        demo                = "k8s-aws"
        area                = "security"
    }
}
