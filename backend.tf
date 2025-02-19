terraform {
  backend "s3" {
    bucket       = "terraform-state-eks-jonatan"
    key          = "terraform/aws-rds/terraform.tfstate"
    region       = "eu-west-1"
    use_lockfile = true
  }
}