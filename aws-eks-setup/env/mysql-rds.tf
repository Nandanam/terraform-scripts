#################################################
# Relational Database Instance(Mysql Instance)
#################################################

##security groups
resource "aws_security_group" "aws-us-west2-preview-mysql-sg" {
  vpc_id = "${var.vpc-id}"
  name = "mysql-sg"
  description = "Allow inbound mysql traffic"
  tags {
    Name = "${var.application-name}-mysql-sg"
  }
}
resource "aws_security_group_rule" "allow-mysql" {
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_group_id = "${aws_security_group.aws-us-west2-preview-mysql-sg.id}"
    source_security_group_id = "${aws_security_group.aws-us-west2-preview-mysql-sg.id}"
}
resource "aws_security_group_rule" "allow-outgoing-mysql" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_group_id = "${aws_security_group.aws-us-west2-preview-mysql-sg.id}"
    cidr_blocks = ["0.0.0.0/0"]
}

## Database Instance

resource "aws_db_instance" "aws-us-west2-preview-rds-mysql-master" {
  count                = 1
  allocated_storage    = "${var.allocate-mysql-storage}"
  engine               = "${var.dbengine-mysql}"
  engine_version       = "${var.engine-version-sql}"
  instance_class       = "${var.rds-mysql-master-instance}"
  identifier           = "${var.identifier-mysql-master}"
  name                 = "${var.mysq-db-name}"
  username             = "${var.mysql-username}"
  password             = "${var.mysql-password}"
  db_subnet_group_name = "${aws_db_subnet_group.aws-us-west2-preview-rds-subnet-groups.id}"
  parameter_group_name = "default.mysql5.7"
  multi_az             = "false"
  vpc_security_group_ids = ["${aws_security_group.aws-us-west2-preview-mysql-sg.id}"]
  storage_type         = "${var.mysql-storage-type}"
  backup_retention_period = "${var.mysql-backup-retention}"
  skip_final_snapshot = "true"
  tags {
      Name = "${var.identifier-mysql-master}"
  }
}
  resource "aws_db_instance" "aws-us-west2-preview-rds-mysql-replica" {
  count                = 1
  allocated_storage    = "${var.allocate-mysql-storage}"
  engine               = "${var.dbengine-mysql}"
  engine_version       = "${var.engine-version-sql}"
  instance_class       = "${var.rds-mysql-replica-instance}"
  identifier           = "${var.identifier-mysql-replica}"
  name                 = "${var.mysq-db-name}"
  username             = "${var.mysql-username}"
  password             = "${var.mysql-password}"
  #db_subnet_group_name = "${aws_db_subnet_group.aws-us-west2-preview-rds-subnet-groups.id}"
  parameter_group_name = "default.mysql5.7"
  multi_az             = "false"
  replicate_source_db  = "${aws_db_instance.aws-us-west2-preview-rds-mysql-master.identifier}"
  vpc_security_group_ids = ["${aws_security_group.aws-us-west2-preview-mysql-sg.id}"]
  storage_type         = "${var.mysql-storage-type}"
  backup_retention_period = "${var.mysql-backup-retention}"
  skip_final_snapshot = "true"
  tags {
      Name = "${var.identifier-mysql-replica}"
  }
}


resource "aws_db_subnet_group" "aws-us-west2-preview-rds-subnet-groups" {
    name = "aws-us-west2-preview-rds-subnet-groups"
    description = "RDS subnet group for mysql"
    #subnet_ids = ["${aws_subnet.aws-us-west2-preview-private-1.id}", "${aws_subnet.aws-us-west2-preview-private-2.id}"]
    subnet_ids = ["${var.private-subnets}"]
    
    tags{
        Name = "${var.application-name}-mysql-subnet-grp"
    }
}
