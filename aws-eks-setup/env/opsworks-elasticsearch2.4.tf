# # ##################################################
# # ## IAM Roles for Ops works
# # ##################################################


# resource "aws_iam_role" "opsworks_ec2_role-eks" {
#     name = "opsworks_ec2_role-eks"
#     assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "ec2.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role" "opsworks_stack_role-eks" {
#   name = "opsworks_stack_role-eks"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "opsworks.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "stack_policy-eks" {
#   name = "stack_policy-eks"
#   role = "${aws_iam_role.opsworks_stack_role-eks.id}"
#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Action": "ec2:*",
#             "Effect": "Allow",
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": "elasticloadbalancing:*",
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": "cloudwatch:*",
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": "autoscaling:*",
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": "iam:CreateServiceLinkedRole",
#             "Resource": "*",
#             "Condition": {
#                 "StringEquals": {
#                     "iam:AWSServiceName": [
#                         "autoscaling.amazonaws.com",
#                         "ec2scheduled.amazonaws.com",
#                         "elasticloadbalancing.amazonaws.com",
#                         "spot.amazonaws.com",
#                         "spotfleet.amazonaws.com",
#                         "transitgateway.amazonaws.com"
#                     ]
#                 }
#             }
#         }
#     ]
# }
# EOF
# }


# resource "aws_iam_role_policy" "terraform_policy_ec2" {
#   name = "terraform_policy_ec2"
#   role = "${aws_iam_role.opsworks_ec2_role-eks.id}"
#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ssm:DescribeAssociation",
#                 "ssm:GetDeployablePatchSnapshotForInstance",
#                 "ssm:GetDocument",
#                 "ssm:DescribeDocument",
#                 "ssm:GetManifest",
#                 "ssm:GetParameters",
#                 "ssm:ListAssociations",
#                 "ssm:ListInstanceAssociations",
#                 "ssm:PutInventory",
#                 "ssm:PutComplianceItems",
#                 "ssm:PutConfigurePackageResult",
#                 "ssm:UpdateAssociationStatus",
#                 "ssm:UpdateInstanceAssociationStatus",
#                 "ssm:UpdateInstanceInformation"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ssmmessages:CreateControlChannel",
#                 "ssmmessages:CreateDataChannel",
#                 "ssmmessages:OpenControlChannel",
#                 "ssmmessages:OpenDataChannel"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2messages:AcknowledgeMessage",
#                 "ec2messages:DeleteMessage",
#                 "ec2messages:FailMessage",
#                 "ec2messages:GetEndpoint",
#                 "ec2messages:GetMessages",
#                 "ec2messages:SendReply"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "cloudwatch:PutMetricData"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ec2:DescribeInstanceStatus"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ds:CreateComputer",
#                 "ds:DescribeDirectories"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "logs:CreateLogGroup",
#                 "logs:CreateLogStream",
#                 "logs:DescribeLogGroups",
#                 "logs:DescribeLogStreams",
#                 "logs:PutLogEvents"
#             ],
#             "Resource": "*"
#         },
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "s3:GetBucketLocation",
#                 "s3:PutObject",
#                 "s3:GetObject",
#                 "s3:GetEncryptionConfiguration",
#                 "s3:AbortMultipartUpload",
#                 "s3:ListMultipartUploadParts",
#                 "s3:ListBucket",
#                 "s3:ListBucketMultipartUploads"
#             ],
#             "Resource": "*"
#         }
#     ]
# }
# EOF
# }



# resource "aws_iam_role_policy" "terraform_policy_s3" {
#   name = "terraform_policy_s3"
#   role = "${aws_iam_role.opsworks_ec2_role-eks.id}"
#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": "s3:*",
#             "Resource": "*"
#         }
#     ]
# }
# EOF
# }

# # ##################################################
# # ## Ops works
# # ##################################################

# resource "aws_security_group" "ops-work-sg" {
#   name        = "ops-work-sg"
#   description = "SSH"

#   ingress {
#     from_port   = 0
#     to_port     = 65535
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
# resource "aws_iam_instance_profile" "opsworks_ec2_profile-eks" {
#     name = "opsworks_ec2_profile-eks"
#     roles = ["${aws_iam_role.opsworks_ec2_role-eks.name}"]
# }

# resource "aws_opsworks_stack" "edcastqa-es-tf" {
# 	name                          = "${var.stack-name}"
# 	region                        = "${var.aws_region}"
# 	service_role_arn              = "${aws_iam_role.opsworks_stack_role-eks.arn}"
# 	default_instance_profile_arn  = "${aws_iam_instance_profile.opsworks_ec2_profile-eks.arn}"
# 	vpc_id                        = "${aws_vpc.main.id}"
# 	default_subnet_id             = "${aws_subnet.edcast-qa-public-subnet.id}"
# 	use_opsworks_security_groups  = "true"
# 	default_os                    = "Amazon Linux 2"
# 	default_ssh_key_name          = "${var.ssh-key}"
# 	default_root_device_type      = "ebs"
# 	use_custom_cookbooks          = "true"
# 	manage_berkshelf              = "true"
# 	configuration_manager_version = "12"
#     #color = "blue"
	
# 	custom_cookbooks_source {
# 		type     = "s3"
# 		url      = "https://s3.us-east-2.amazonaws.com/edcast-eks-elasticsearch-us-east-2/cookbook/cookbooks_elasticsearch_edcastqa-es-tf.zip"
# 		username = "${var.aws_access_key}"
#         password = "${var.aws_secret_key}"
# 	}
#     custom_json = <<EOT
# {
#    "elasticsearch": {
#        "nginx": {
#            "users": [
#                {
#                    "username": "edcast",
#                    "password": "edcastpass"
#                }
#            ],
#            "allow_cluster_api": "true",
#            "allow_status": "true",
#            "port": 80
#        },
#        "cluster.name": "edcastqa-es-tf",
#        "discovery.ec2.tag.opsworks:stack": "edcastqa-es-tf",
#        "cloud.node.auto_attributes": "true"
#    }
# }
# EOT
   
# }


# resource "aws_opsworks_custom_layer" "edcastqa-es-layer" {
# 	stack_id                  = "${aws_opsworks_stack.edcastqa-es-tf.id}"
# 	name                      = "${var.stack-name}"
#     short_name                = "${var.stack-name}"
# 	auto_assign_elastic_ips   = "false"
#     auto_assign_public_ips    = "true"
#     #custom_security_group_ids = ["${aws_security_group.ops-work-sg.name}"]
# 	install_updates_on_boot   = "true"
#     custom_setup_recipes      = ["edcast_elasticsearch_chef::edcastqa-es-tf","edcast_elasticsearch_chef::proxy"]
     

    
# }

# resource "aws_opsworks_instance" "edcastqa-es-instances" {
#   count     = "2"
#   stack_id  = "${aws_opsworks_stack.edcastqa-es-tf.id}"

#   layer_ids = [
#     "${aws_opsworks_custom_layer.edcastqa-es-layer.id}",
#   ]

#   instance_type    = "${var.ops-instance-type}"
#   os               = "Custom"
#   ami_id           = "${var.ops-work-ami}"
#   root_device_type = "ebs"
#   state            = "stopped"

# }