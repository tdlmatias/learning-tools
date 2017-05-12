# Launch instances to serve as K8s workers
resource "aws_instance" "workers" {
    ami                         = "${data.aws_ami.k8s_ami.id}"
    count                       = "${var.worker_count}"
    instance_type               = "${var.worker_flavor}"
    key_name                    = "${var.keypair}"
    vpc_security_group_ids      = [ "${aws_security_group.k8s_sg.id}" ]
    subnet_id                   = "${aws_subnet.k8s_subnet.id}"
    associate_public_ip_address = true
    source_dest_check           = false
    private_ip                  = "${cidrhost(var.vpc_cidr, 30 + count.index)}"
    depends_on                  = [ "aws_internet_gateway.k8s_gw" ]
    tags {
        Name                    = "worker-${count.index}"
        tool                    = "terraform"
        demo                    = "k8s-aws"
        area                    = "instances"
        role                    = "worker"
    }
}

output "workers_public_ip" {
    value = "${join(",", aws_instance.workers.*.public_ip)}"
}
