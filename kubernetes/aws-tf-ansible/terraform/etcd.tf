# Launch instances to serve as etcd cluster
resource "aws_instance" "etcd_instances" {
    ami                         = "${data.aws_ami.etcd_ami.id}"
    count                       = "${var.etcd_count}"
    instance_type               = "${var.etcd_flavor}"
    key_name                    = "${var.keypair}"
    vpc_security_group_ids      = [ "${aws_security_group.k8s_sg.id}" ]
    subnet_id                   = "${aws_subnet.k8s_subnet.id}"
    associate_public_ip_address = true
    private_ip                  = "${cidrhost(var.vpc_cidr, 10 + count.index)}"
    depends_on                  = [ "aws_internet_gateway.k8s_gw" ]
    user_data                   = "${file("cloud-config.yml")}"
    tags {
        Name                    = "etcd-${count.index}"
        tool                    = "terraform"
        demo                    = "k8s-aws"
        area                    = "instances"
        role                    = "etcd"
    }
}

output "etcd_instances_public_ip" {
    value = "${join(",", aws_instance.etcd_instances.*.public_ip)}"
}
