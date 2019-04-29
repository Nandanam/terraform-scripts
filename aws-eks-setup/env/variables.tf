#################################################
# Variable Configurations
#################################################

#AWS Credentials
# variable "aws_access_key"{}
# variable "aws_secret_key"{}
variable "aws_region"{
  description = "Region to build infrastructure. EKS is supported in us-east-1(N.Virginia),us-east-2(Ohio) and us-west-2(Oregon)."
  default     = "us-west-2"
}
variable "application-name" {
  description = "Name of the Environment"
  default     = "aws-us-west2-preview"
  type        = "string"
}
variable "key-name" {
  default="aws-us-west2-preview"
}

variable "key-path" {
  default = "/Users/nandanamvikas/Documents/aws-env/aws-keys/aws-us-west2-preview.pem"
}

variable "vpc-id" {
  default = "vpc-0d1042a2779181969"
}
variable "public-subnets" {
  default = "subnet-0e0f0ed2562367a98"
}
variable "private-subnets" {
  default = ["subnet-0da0f7a4e7799b2b7", "subnet-067b132b68fdd2d47"]
}




##################################################
## Elastic Kubernetes Service Worker nodes
##################################################
variable "cluster-node-size" {
  description = "Number of nodes desired in the eks cluster"
  default     = 2 
}

variable "max-size-nodes" {
  description = "Maximum number of nodes to scale, the number should always be greater than node size given above"
  default     = 7  
}

variable "eks-instance-type" {
  description = "The instance type of nodes to be created(eg: m4.large,t2.micro etc)"
  default     = "m5.xlarge"
}

# variable "eks-instance-type" {
#   default = "r5a.large"
# }
variable "eks-version" {
  default = "1.11"
}


##################################################
## Mysql RDS instance variables
##################################################

variable "allocate-mysql-storage" {
  description = "(Required unless a snapshot_identifier or replicate_source_db is provided) The allocated storage in gibibytes."
  default     = 100
}

variable "dbengine-mysql" {
  description = "(Required unless a snapshot_identifier or replicate_source_db is provided) The database engine to use. For supported values, see the Engine parameter in API action CreateDBInstance. Note that for Amazon Aurora instances the engine must match the DB cluster's engine"
  default     = "mysql"
}

variable "engine-version-sql" {
  description = "(Optional) The engine version to use. If auto_minor_version_upgrade is enabled, you can provide a prefix of the version such as 5.7 (for 5.7.10) and this attribute will ignore differences in the patch version automatically (e.g. 5.7.17)"
  default     = "5.7"
}

variable "identifier-mysql-master" {
  default = "preview-mysql-master"
}

variable "identifier-mysql-replica" {
  default = "preview-mysql-replica"
}

variable "rds-mysql-master-instance" {
  default = "db.t3.medium"
}
variable "rds-mysql-replica-instance" {
  default = "db.t3.medium"
}
variable "mysq-db-name" {
  description = "no special characters allowed (Optional) The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Note that this does not apply for Oracle or SQL Server engines. "
  default     = "lxpdb"
}
variable "mysql-master-db-name" {
  default ="edcastqamysqlmaster"
  
}
variable "mysql-username" {
  description = "(Required unless a snapshot_identifier or replicate_source_db is provided) Username for the master DB user."
  default     = "root"
}
variable "mysql-password" {
  description = " Minimum 8 characters.Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file."
}
variable "mysql-storage-type" {
  description = "(Optional) One of standard (magnetic), gp2 (general purpose SSD), or io1 (provisioned IOPS SSD) "
  default     = "gp2"
}
variable "mysql-backup-retention" {
  description = "(Optional) The days to retain backups for. Must be between 0 and 35. When creating a Read Replica the value must be greater than 0."
  default     = "30"
}


# # ##################################################
# # ## Postgres RDS instance variables
# # ##################################################

variable "allocate-postgres-storage" {
  description = "(Required unless a snapshot_identifier or replicate_source_db is provided) The allocated storage in gibibytes."
  default     = 10
}
variable "dbengine-postgres" {
  description = "(Required unless a snapshot_identifier or replicate_source_db is provided) The database engine to use. For supported values, see the Engine parameter in API action CreateDBInstance. Note that for Amazon Aurora instances the engine must match the DB cluster's engine"
  default     = "postgres"
}
variable "engine-version-postgres" {
  description = "(Optional) The engine version to use. If auto_minor_version_upgrade is enabled, you can provide a prefix of the version such as 5.7 (for 5.7.10) and this attribute will ignore differences in the patch version automatically (e.g. 5.7.17)"
  default     = "9.6.3"
}
variable "rds-postgres-instance" {
  description = "(Required) The instance type of the RDS instance."
  default     = "db.t2.medium"
}
variable "instance-identifier-postgres" {
  description = "Optional, Forces new resource) The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier."
  default     = "preview-postgres-master"
}
variable "instance-identifier-postgres-replica" {
  description = "Optional, Forces new resource) The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier."
  default = "preview-postgres-replica"
}

variable "postgres-db-name" {
  description = "no special characters allowed (Optional) The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance. Note that this does not apply for Oracle or SQL Server engines. "
  default     = "previewdb"
}
variable "postgres-username" {
  description = "(Required unless a snapshot_identifier or replicate_source_db is provided) Username for the master DB user."
  default     = "root"
}
variable "postgres-password" {
  description = "Minimum 8 characters Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file."
}
variable "postgres-storage-type" {
  description = "(Optional) One of standard (magnetic), gp2 (general purpose SSD), or io1 (provisioned IOPS SSD) "
  default     = "gp2"
}
variable "postgres-backup-retention" {
  description = "(Optional) The days to retain backups for. Must be between 0 and 35. When creating a Read Replica the value must be greater than 0."
  default     = "30"
}

# ##################################################
# ## Redis Cluster 
# ##################################################
# variable "redis-cluster-id" {
#   description = "(Required) Group identifier. ElastiCache converts this name to lowercase"
#   type        ="map"
#   default     ={
#     "0" ="preview-lxp"
#     "1" ="preview-superadmin"
#     "2" ="preview-ecl"
#     "3" ="preview-rss-collector"
#     "4" ="preview-integration"
#     "5" ="preview-lms"
#     "6" ="preview-collector"
#   }
# }
variable "redis-engine" {
  description = "(Required unless replication_group_id is provided) Name of the cache engine to be used for this cache cluster. Valid values for this parameter are memcached or redis"
  default     = "redis"
}
variable "redis-engine-version"{
  description = "(Optional) Version number of the cache engine to be used."
  default     = "5.0"
}
variable "redis-maintenance-window" {
  description = "Optional) Specifies the weekly time range for when maintenance on the cache cluster is performed."
  default     = "sun:05:00-sun:06:00"
}
variable "redis-instance-type" {
  description = "(Required unless replication_group_id is provided) The compute and memory capacity of the nodes"
  default     = "cache.t2.medium"
}
variable "redis-cache-nodes"{
  description = "Number of cache nodes"
  default     = 1
}
variable "redis-name" {
  type = "map"
  default = {
    "0" = "preview-lxp"
    "1" = "preview-superadmin"
    "2" = "preview-ecl-app"
    "3" = "preview-rss-app"
    "4" = "preview-integration"
    "5" = "preview-lms-app"
    "6" = "preview-collector"
  }
}
variable "redis-parameter_group_name"{
  #description = ""
  default      = "default.redis5.0"
}
# ##################################################
# ## Memcache 
# ##################################################
variable "memcache-cluster-id" {
  description = "(Required) Group identifier. ElastiCache converts this name to lowercase"
  default     = "edcast-stage"
}
variable "memcache-engine" {
  description = "(Required unless replication_group_id is provided) Name of the cache engine to be used for this cache cluster. Valid values for this parameter are memcached or redis"
  default     = "memcached"
}
variable "memcache-engine-version"{
  description = "(Optional) Version number of the cache engine to be used."
  default     = "1.4.33"
}
variable "memcache-maintenance-window" {
  description = "Optional) Specifies the weekly time range for when maintenance on the cache cluster is performed."
  default     = "sun:05:00-sun:06:00"
}
variable "memcache-instance-type" {
  description = "(Required unless replication_group_id is provided) The compute and memory capacity of the nodes"
  default     = "cache.m4.large"
}
variable "memcache-cache-nodes"{
  description = "Number of cache nodes"
  default     = 1
}
variable "memcache-parameter_group_name"{
  #description = ""
  default      = "default.memcached1.4"
}

# ##################################################
# ## Bastion Host 
# ##################################################

variable "ami_id" {
  type    = "map"
  default = {
    "us-east-1" = "ami-035be7bafff33b6b6"
    "us-west-2" = "ami-036affea69a1101c9"
    "us-east-2" = "ami-0cd3dfa4e37921605"
    "eu-central-1"= "ami-09def150731bdbcc2"
  }  
}
variable "ec2-instance-type" {
  default = "t2.micro"
}
# variable "key_pair_name"{
#   default = "us-east-2-key"
# }
# variable "key-path" {
#   default = "/Users/nandanamvikas/Downloads/eks-terraform.pem"
# }

# ##################################################
# ## Elasticsearch 2.4
# ##################################################
variable "es24-instance-type" {
  default= "t2.medium"
}
variable "es24-ami" {
  type = "map"
  default = {
    "us-east-1" = "ami-011b3ccf1bd6db744"
    "us-west-2" = "ami-036affea69a1101c9"
    "us-east-2" = "ami-0b500ef59d8335eee"
    "eu-central-1" = "ami-c86c3f23"

  }
}



##################################################
## S3 Bucket
##################################################

variable "s3bucket-name" {
  description = "Give an unique name to the bucket"
  default = "edcast-terraform-auto"  
}

##################################################
## Ops Works Elasticsearch 2.4
##################################################


variable "stack-name" {
  description = "The name of stack for ops works. Make sure the stack name matches with recepie name in chef script"
  default     = "eks-auto"
}

variable "ssh-key" {
  description = "name of key pair to ssh into instance"
  default = "aws-vikas-us-west-2"
}

variable "ops-instance-type"{
  description = "instance type for ops works instances"
  default = "m4.large"
}

variable "ops-work-ami" {
  description = "ami for ops-works instance"
  default = "ami-fbb4ee9e"
}
