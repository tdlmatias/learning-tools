terraform {
    backend "s3" {
        bucket  = "itx2017demo"
        key     = "k8s-aws/terraform.tfstate"
        region  = "us-west-2"
        encrypt = true
    }
}
