# ##################################################
# ## Bastion Host EC2
# ##################################################
# # resource "aws_security_group" "edcast-qa-bastion-sg" {
# #   vpc_id = "${aws_vpc.main.id}"
# #   name = "bastion-sg"
# #   description = "Allow inbound http traffic"
# #   tags {
# #     Name = "${var.application-name}-bastion-sg"
# #   }
# # }
# # resource "aws_security_group_rule" "allow-http" {
# #     type = "ingress"
# #     from_port = 80
# #     to_port = 80
# #     protocol = "tcp"
# #     security_group_id = "${aws_security_group.edcast-qa-bastion-sg.id}"
# #     source_security_group_id = "${aws_security_group.edcast-qa-bastion-sg.id}"
# # }
# # resource "aws_security_group_rule" "allow-ssh" {
# #     type = "ingress"
# #     from_port = 22
# #     to_port = 22
# #     protocol = "tcp"
# #     security_group_id = "${aws_security_group.edcast-qa-bastion-sg.id}"
# #     source_security_group_id = "${aws_security_group.edcast-qa-bastion-sg.id}"
# # }

# # resource "aws_security_group_rule" "allow-outgoing-http" {
# #     type = "egress"
# #     from_port = 0
# #     to_port = 0
# #     protocol = "-1"
# #     security_group_id = "${aws_security_group.edcast-qa-bastion-sg.id}"
# #     cidr_blocks = ["0.0.0.0/0"]
# # }
# resource "aws_security_group" "rds_test_nat" {
#   name = "rds_test_nat"
#   description = "Allow SSH"

#   ingress {
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port = 22
#     to_port = 22
#     protocol = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   vpc_id = "${var.vpc_id}"
# }
# data "aws_ami" "bastion" {
#   filter {
#     name = "state"
#     values = ["available"]
#   }
#   filter {
#     name = "tag:Name"
#     values = ["bastion"]
#   }
#   most_recent = true
# }

# resource "aws_instance" "ec2_instance" {
#     #ami                         = "${lookup(var.ami_id, var.aws_region)}"
#     ami                         = "${data.aws_ami.bastion.id}"
#     count                       = 1
#     #subnet_id                   = "${aws_subnet.edcast-qa-subnet.id}"
#     instance_type               = "${var.ec2-instance-type}"
#     key_name                    = "${var.key-name}"
#     associate_public_ip_address = "true"
#     #security_groups             =  ["${aws_security_group.edcast-qa-bastion-sg.id}"]
#     tags{
#         Name        = "${var.application-name}-bastion-host"
#     }
# }