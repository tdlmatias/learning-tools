module "taskgroup-01" {
    source                      = "./modules/taskgroup"
    tg_name                     = "taskgroup-01"

    tg_ami_id                   = "${data.aws_ami.atomic_ami.id}"
    tg_vpc_id                   = "${data.aws_vpc.default.id}"
    tg_type                     = "${var.instance_type}"
    tg_keyname                  = "${var.keyname}"

    tg_port                     = "22"
    tg_proto                    = "tcp"

    tg_subnet_cidr              = "172.31.48.0/24"

    tg_min_size                 = "2"
    tg_max_size                 = "2"
    tg_capacity                 = "2"
}
