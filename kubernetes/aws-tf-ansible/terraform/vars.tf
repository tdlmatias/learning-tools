variable "keypair" {
    type                    = "string"
    description             = "SSH keypair to use to connect to instances"
    default                 = "itx_rsa"
}

variable "etcd_flavor" {
    type                    = "string"
    description             = "AWS type to use for etcd instances"
    default                 = "t2.small"
}

variable "etcd_count" {
    type                    = "string"
    description             = "Number of etcd instances to create"
    default                 = "3"
}

variable "controller_flavor" {
    type                    = "string"
    description             = "AWS type to use for K8s controller instances"
    default                 = "t2.small"
}

variable "controller_count" {
    type                    = "string"
    description             = "Number of K8s controller instances to create"
    default                 = "3"
}

variable "worker_flavor" {
    type                    = "string"
    description             = "AWS type to use for K8s worker instances"
    default                 = "t2.micro"
}

variable "worker_count" {
    type                    = "string"
    description             = "Number of K8s worker instances to create"
    default                 = "3"
}

variable "user_region" {
    type                    = "string"
    description             = "AWS region to use by default"
    default                 = "us-west-2"
}

variable "kubernetes_cluster_dns" {
    default                 = "10.32.0.10"
}

variable "vpc_cidr" {
    type                    = "string"
    description             = "CIDR to use for new VPC"
    default                 = "10.200.0.0/16"
}
