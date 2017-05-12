# Launch instances to serve as K8s controllers
resource "aws_instance" "controllers" {
    ami                         = "${data.aws_ami.k8s_ami.id}"
    count                       = "${var.controller_count}"
    instance_type               = "${var.controller_flavor}"
    key_name                    = "${var.keypair}"
    vpc_security_group_ids      = [ "${aws_security_group.k8s_sg.id}",
                                    "${aws_security_group.k8s_api_sg.id}" ]
    subnet_id                   = "${aws_subnet.k8s_subnet.id}"
    associate_public_ip_address = true
    source_dest_check           = false
    private_ip                  = "${cidrhost(var.vpc_cidr, 20 + count.index)}"
    depends_on                  = [ "aws_internet_gateway.k8s_gw" ]
    tags {
        Name                    = "controller-${count.index}"
        tool                    = "terraform"
        demo                    = "k8s-aws"
        area                    = "instances"
        role                    = "controller"
    }
}

output "controllers_public_ip" {
    value = "${join(",", aws_instance.controllers.*.public_ip)}"
}
