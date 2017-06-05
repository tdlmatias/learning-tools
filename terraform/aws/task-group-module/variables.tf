variable "user_region" {
    type                    = "string"
    description             = "AWS region to use for all resources"
}

variable "instance_type" {
    type                    = "string"
    description             = "Type of instance to create (t2.micro, for example)"
}

variable "keyname" {
    type                    = "string"
    description             = "Name of SSH keypair to use for instances"
}
