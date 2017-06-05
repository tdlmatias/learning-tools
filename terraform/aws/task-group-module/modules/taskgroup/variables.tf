# Variables that represent existing objects to reference
variable "tg_ami_id" {
    type                    = "string"
    description             = "ID of AMI to use in launch configuration"
}

variable "tg_vpc_id" {
    type                    = "string"
    description             = "ID of existing VPC to use"
}

variable "tg_type" {
    type                    = "string"
    description             = "Instance type to use in this task group"
}

variable "tg_keyname" {
    type                    = "string"
    description             = "Name of keypair to use for instances in this task group"
}

# Variables used to create new objects
variable "tg_name" {
    type                    = "string"
    description             = "Task group-specific name"
}

variable "tg_proto" {
    type                    = "string"
    description             = "Protocol (TCP/UDP/HTTP/HTTPS) used by this task group"
}

variable "tg_port" {
    type                    = "string"
    description             = "Protocol port used by this task group"
}

variable "tg_subnet_cidr" {
    type                    = "string"
    description             = "CIDR to use for task group subnet"
}

variable "tg_min_size" {
    type                    = "string"
    description             = "Minimum number of instances in this task group"
}

variable "tg_max_size" {
    type                    = "string"
    description             = "Maximum number of instances in this task group"
}

variable "tg_capacity" {
    type                    = "string"
    description             = "Desired capacity for this task group"
}
