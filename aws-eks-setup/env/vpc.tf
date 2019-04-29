# # ##################################################
# # ## Virtual Private Cloud
# # ##################################################
# #
# # VPC Resources
# #  * VPC
# #  * Subnets
# #  * Internet Gateway
# #  * Route Table
# #

# resource "aws_vpc" "eu-central1-preview-vpc" {
#     cidr_block = "10.0.0.0/16"
#     instance_tenancy = "default"
#     enable_dns_support = "true"
#     enable_dns_hostnames = "true"
#     enable_classiclink = "false"
#     tags {
#         Name = "${var.application-name}"
#     }
# }
# resource "aws_security_group" "eu-central1-preview-vpc-sg" {
#   name        = "eu-central1-preview-vpc-sg"
#   description = "Allow all inbound traffic"
#   vpc_id = "${aws_vpc.eu-central1-preview-vpc.id}"

#   ingress {
#     from_port   = 0
#     to_port     = 65535
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "allow_all"
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }

# # Subnets
# resource "aws_subnet" "aws-eu-central1-preview-subnet" {
#     count = 2

#   availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
#   cidr_block        = "10.0.${count.index}.0/24"

#     vpc_id = "${aws_vpc.eu-central1-preview-vpc.id}"
#     #cidr_block = "10.0.1.0/24"
#     map_public_ip_on_launch = "true"
#     #availability_zone = "us-west-2a"

#     tags {
#         Name = "${var.application-name}"
#     }
# }
# resource "aws_route_table" "eu-central1-preview-rt-public" {
#     vpc_id = "${aws_vpc.eu-central1-preview-vpc.id}"
#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = "${aws_internet_gateway.eu-central1-preview-igw.id}"
#     }

#     tags {
#         Name = "${var.application-name}"
#     }
# }



# resource "aws_subnet" "aws-eu-central1-preview-public-subnet" {
#     vpc_id = "${aws_vpc.eu-central1-preview-vpc.id}"
#     cidr_block = "10.0.6.0/24"
#     map_public_ip_on_launch = "false"
#     #availability_zone = "us-east-2a"

#     tags {
#         Name = "${var.application-name}-public-subnet-1"
#     }
# }

# resource "aws_route_table_association" "aws-eu-central1-preview-rt-subnet-assoc-public" {
#   count = 1

#   subnet_id      = "${aws_subnet.aws-eu-central1-preview-public-subnet.id}"
#   route_table_id = "${aws_route_table.eu-central1-preview-rt-public.id}"
# }
