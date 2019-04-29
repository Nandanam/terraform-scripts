# ##################################################
# ## Memcache 
# ##################################################

resource "aws_security_group" "aws-us-west2-preview-memcache-sg" {
  vpc_id = "${var.vpc-id}"
  name = "memcache-sg"
  tags {
    Name = "${var.application-name}-memcache-sg"
  }
}
resource "aws_security_group_rule" "allow-memcache" {
    type = "ingress"
    from_port = 11211
    to_port = 11211
    protocol = "tcp"
    security_group_id = "${aws_security_group.aws-us-west2-preview-memcache-sg.id}"
    source_security_group_id = "${aws_security_group.aws-us-west2-preview-memcache-sg.id}"
}
resource "aws_security_group_rule" "allow-outgoing-memcache" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_group_id = "${aws_security_group.aws-us-west2-preview-memcache-sg.id}"
    cidr_blocks = ["0.0.0.0/0"]
}
resource "aws_elasticache_subnet_group" "aws-us-west2-preview-memcache-subnet-grp" {
    name = "aws-us-west2-preview-memcache-subnet-grp"
    description = "Memcache subnet group "
    subnet_ids = ["${var.private-subnets}"]
    
}

resource "aws_elasticache_cluster" "aws-us-west2-preview-memcache" {
  count                = 1
  cluster_id           = "${var.application-name}"
  engine               = "${var.memcache-engine}"
  engine_version       = "${var.memcache-engine-version}"
  maintenance_window   = "${var.memcache-maintenance-window}"
  node_type            = "${var.memcache-instance-type}"
  num_cache_nodes      = "${var.memcache-cache-nodes}"
  parameter_group_name = "${var.memcache-parameter_group_name}"
  port                 = "11211"
  subnet_group_name    = "${aws_elasticache_subnet_group.aws-us-west2-preview-memcache-subnet-grp.name}"
  security_group_ids   = ["${aws_security_group.aws-us-west2-preview-memcache-sg.id}"]
  tags {
      Name = "${var.application-name}"
  }
}
