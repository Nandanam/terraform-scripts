##################################################
## Outputs
##################################################

locals {
  config-map-aws-auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.aws-us-west2-preview-node.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH

  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.aws-us-west2-preview.endpoint}
    certificate-authority-data: ${aws_eks_cluster.aws-us-west2-preview.certificate_authority.0.data}
  name: ${var.application-name}
contexts:
- context:
    cluster: ${var.application-name}
    user: ${var.application-name}
  name: ${var.application-name}
current-context: ${var.application-name}
kind: Config
preferences: {}
users:
- name: ${var.application-name}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.application-name}"
KUBECONFIG
}

output "config-map-aws-auth" {
  value = "${local.config-map-aws-auth}"
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}

##Output Variables of RDS instance
# output "rds-username"{
#   value ="${aws_db_instance.aws-us-west2-preview-rds.username}"
# }
# output "rds-password"{
#   value = "${aws_db_instance.aws-us-west2-preview-rds.password}"
# }

# output "rds-endpoint"{
#   value = "${aws_db_instance.aws-us-west2-preview-rds.endpoint}"
# }

##Output Variables of 


