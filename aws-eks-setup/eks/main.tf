terraform {
  backend "s3" {
    bucket  = "aws-us-west2-preview-eks-terraform-state"
    region  = "us-west-2"
    key     = "terraform.tfstate"
    encrypt = true    
  }
}
