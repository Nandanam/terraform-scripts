# # ##################################################
# # ##  Outputs
# # ##################################################
# locals {
#   config-map-aws-auth = <<CONFIGMAPAWSAUTH


# apiVersion: v1
# kind: ConfigMap
# metadata:
#   name: aws-auth
#   namespace: kube-system
# data:
#   mapRoles: |
#     - rolearn: ${aws_iam_role.edcast-eks-node-role.arn}
#       username: system:node:{{EC2PrivateDNSName}}
#       groups:
#         - system:bootstrappers
#         - system:nodes
# CONFIGMAPAWSAUTH

#   kubeconfig = <<KUBECONFIG


# apiVersion: v1
# clusters:
# - cluster:
#     server: ${aws_eks_cluster.edc.endpoint}
#     certificate-authority-data: ${aws_eks_cluster.edc.certificate_authority.0.data}
#   name: kubernetes
# contexts:
# - context:
#     cluster: kubernetes
#     user: aws
#   name: aws
# current-context: aws
# kind: Config
# preferences: {}
# users:
# - name: aws
#   user:
#     exec:
#       apiVersion: client.authentication.k8s.io/v1alpha1
#       command: aws-iam-authenticator
#       args:
#         - "token"
#         - "-i"
#         - "${var.application-name}"
# KUBECONFIG
# }

# output "config-map-aws-auth" {
#   value = "${local.config-map-aws-auth}"
# }

# output "kubeconfig" {
#   value = "${local.kubeconfig}"
# }
# output "vpc-id"{
#   value = "${aws_vpc.main.id}"
# }
# output "rds-edc-workflow"{
#   value = "${aws_db_instance.edcast-qa-rds-mysql-edc-workflow.endpoint}"
# }

# output "rds-edc-staging-master"{
#   value = "${aws_db_instance.edcast-staging-rds-mysql-master.endpoint}"
# }

# output "rds-edc-staging-replica"{
#   value = "${aws_db_instance.edcast-staging-rds-mysql-replica.endpoint}"
# }
# output "rds-ecl" {
#   value = "${aws_db_instance.edcast-qa-rds-postgres.endpoint}"
# }

# output "cloud-front"{
#   value = "${aws_cloudfront_distribution.edc-qanew-main.id}"
# }

# output "memcache"{
#   value = "${aws_elasticache_cluster.edcast-qa-memcache.configuration_endpoint}"
# }
