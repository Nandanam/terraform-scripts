# #################################################
# # Elastic Kubernetes Service
# #################################################

# # EKS Cluster Resources
# #  * IAM Role to allow EKS service to manage other AWS services
# #  * EC2 Security Group to allow networking traffic with EKS cluster
# #  * EKS Cluster


# resource "aws_iam_role" "aws-eu-central1-preview-eks-cluster" {
#   name = "${var.application-name}-eks-cluster"

#   assume_role_policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "eks.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# POLICY
# }

# resource "aws_iam_role_policy_attachment" "aws-eu-central1-preview-cluster-AmazonEKSClusterPolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = "${aws_iam_role.aws-eu-central1-preview-eks-cluster.name}"
# }

# resource "aws_iam_role_policy_attachment" "aws-eu-central1-preview-cluster-AmazonEKSServicePolicy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
#   role       = "${aws_iam_role.aws-eu-central1-preview-eks-cluster.name}"
# }

# resource "aws_security_group" "aws-eu-central1-preview-cluster" {
#   name        = "${var.application-name}-cluster-sg"
#   description = "Cluster communication with worker nodes"
#   vpc_id      = "${aws_vpc.eu-central1-preview-vpc.id}"

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags {
#     Name = "${var.application-name}"
#   }
# }

# resource "aws_security_group_rule" "aws-eu-central1-preview-cluster-ingress-node-https" {
#   description              = "Allow pods to communicate with the cluster API Server"
#   from_port                = 443
#   protocol                 = "tcp"
#   security_group_id        = "${aws_security_group.aws-eu-central1-preview-cluster.id}"
#   source_security_group_id = "${aws_security_group.aws-eu-central1-preview-node-sg.id}"
#   to_port                  = 443
#   type                     = "ingress"
# }

# resource "aws_security_group_rule" "aws-eu-central1-preview-cluster-ingress-workstation-https" {
#   cidr_blocks       = ["${local.workstation-external-cidr}"]
#   description       = "Allow workstation to communicate with the cluster API Server"
#   from_port         = 443
#   protocol          = "tcp"
#   security_group_id = "${aws_security_group.aws-eu-central1-preview-cluster.id}"
#   to_port           = 443
#   type              = "ingress"
# }

# resource "aws_eks_cluster" "aws-eu-central1-preview" {
#   name     = "${var.application-name}"
#   role_arn = "${aws_iam_role.aws-eu-central1-preview-eks-cluster.arn}"
#   version  = "${var.eks-version}" 
#   vpc_config {
#     security_group_ids = ["${aws_security_group.aws-eu-central1-preview-cluster.id}"]
#     subnet_ids         = ["${aws_subnet.aws-eu-central1-preview-subnet.*.id}"]
#   }

#   depends_on = [
#     "aws_iam_role_policy_attachment.aws-eu-central1-preview-cluster-AmazonEKSClusterPolicy",
#     "aws_iam_role_policy_attachment.aws-eu-central1-preview-cluster-AmazonEKSServicePolicy",
#   ]
# }
