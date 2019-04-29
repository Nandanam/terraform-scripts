##################################################
## Variable Configurations
##################################################

##AWS Credentials
# variable "access_key"{}
# variable "secret_key"{}
variable "aws_region"{
  description = "Region to build infrastructure"
  default = "us-west-2"
}
variable "cluster-name" {
  default = "aws-us-west2-preview"
}
variable "application-name" {
  default = "aws-us-west2-preview"
}

variable "key_pair_name" {
  default = "aws-us-west2-preview"
}




