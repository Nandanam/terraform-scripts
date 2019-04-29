##################################################
## Relational Database Instance(Postgres Instance)
##################################################
resource "aws_security_group" "aws-us-west2-preview-postgres-sg" {
  vpc_id = "${var.vpc-id}"
  name = "postgres-sg"
  description = "Allow inbound postgres traffic"
  tags {
    Name = "${var.application-name}-postgres-sg"
  }
}
resource "aws_security_group_rule" "allow-postgres" {
    type = "ingress"
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_group_id = "${aws_security_group.aws-us-west2-preview-postgres-sg.id}"
    source_security_group_id = "${aws_security_group.aws-us-west2-preview-postgres-sg.id}"
}
resource "aws_security_group_rule" "allow-outgoing-postgres" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_group_id = "${aws_security_group.aws-us-west2-preview-postgres-sg.id}"
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_db_instance" "aws-us-west2-preview-rds-postgres" {
  allocated_storage    = "${var.allocate-postgres-storage}"
  engine               = "${var.dbengine-postgres}"
  engine_version       = "${var.engine-version-postgres}"
  instance_class       = "${var.rds-postgres-instance}"
  identifier           = "${var.instance-identifier-postgres}"
  name                 = "${var.postgres-db-name}"
  username             = "${var.postgres-username}"
  password             = "${var.postgres-password}"
  db_subnet_group_name = "${aws_db_subnet_group.aws-us-west2-preview-rds-subnet-groups.id}"
  multi_az             = "false"
  vpc_security_group_ids = ["${aws_security_group.aws-us-west2-preview-postgres-sg.id}"]
  storage_type         = "${var.postgres-storage-type}"
  backup_retention_period = "${var.postgres-backup-retention}"
  skip_final_snapshot = "true"
  tags {
      Name = "${var.instance-identifier-postgres}"
  }
}
#   resource "aws_db_instance" "aws-us-west2-preview-postgres-replica" {
#   count                = 1
#   allocated_storage    = "${var.allocate-postgres-storage}"
#   engine               = "${var.dbengine-postgres}"
#   engine_version       = "${var.engine-version-postgres}"
#   instance_class       = "${var.rds-postgres-instance}"
#   identifier           = "${var.instance-identifier-postgres-replica}"
#   name                 = "${var.postgres-db-name}"
#   username             = "${var.postgres-username}"
#   password             = "${var.postgres-password}"
#   #db_subnet_group_name = "${aws_db_subnet_group.aws-us-west2-preview-rds-subnet-groups.id}"
#   #parameter_group_name = "default.postgres9.6"
#   multi_az             = "false"
#   replicate_source_db  = "${aws_db_instance.aws-us-west2-preview-rds-postgres.identifier}"
#   vpc_security_group_ids = ["${aws_security_group.aws-us-west2-preview-postgres-sg.id}"]
#   storage_type         = "${var.postgres-storage-type}"
#   #backup_retention_period = "${var.postgres-backup-retention}"
#   skip_final_snapshot = "true"
#   tags {
#       Name = "${var.instance-identifier-postgres-replica}"
#   }
# }