variable "keypair" {
    type                    = "string"
    description             = "SSH keypair to use to connect to instances"
}

variable "etcd_size" {
    type                    = "string"
    description             = "AWS type to use for etcd instances"
}

variable "etcd_count" {
    type                    = "string"
    description             = "Number of etcd instances to create"
}

variable "controller_size" {
    type                    = "string"
    description             = "AWS type to use for K8s controller instances"
}

variable "controller_count" {
    type                    = "string"
    description             = "Number of K8s controller instances to create"
}

variable "worker_size" {
    type                    = "string"
    description             = "AWS type to use for K8s worker instances"
}

variable "worker_count" {
    type                    = "string"
    description             = "Number of K8s worker instances to create"
}

variable "user_region" {
    type                    = "string"
    description             = "AWS region to use by default"
}

variable "kubernetes_cluster_dns" {
    default                 = "10.32.0.10"
}

variable "vpc_cidr" {
    type                    = "string"
    description             = "CIDR to use for new VPC"
    default                 = "10.200.0.0/16"
}
