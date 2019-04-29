# ##################################################
# ## Redis Cluster
# ##################################################
resource "aws_security_group" "aws-us-west2-preview-redis-sg" {
  vpc_id = "${var.vpc-id}"
  name = "redis-sg"
  description = "Allow inbound redis traffic"
  tags {
    Name = "${var.application-name}-redis-sg"
  }
}
resource "aws_security_group_rule" "allow-redis" {
    type = "ingress"
    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    security_group_id = "${aws_security_group.aws-us-west2-preview-redis-sg.id}"
    source_security_group_id = "${aws_security_group.aws-us-west2-preview-redis-sg.id}"
}
resource "aws_security_group_rule" "allow-outgoing-redis" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_group_id = "${aws_security_group.aws-us-west2-preview-redis-sg.id}"
    cidr_blocks = ["0.0.0.0/0"]
}
resource "aws_elasticache_subnet_group" "aws-us-west2-preview-redis-subnet-grp" {
    name = "aws-us-west2-preview-redis-subnet-grp"
    description = "Redis subnet group"
    subnet_ids = ["${var.private-subnets}"]
    
}

resource "aws_elasticache_cluster" "aws-us-west2-preview-redis" {
  count                = 7
  cluster_id           = "${lookup(var.redis-name, count.index)}"
  engine               = "${var.redis-engine}"
  engine_version       = "${var.redis-engine-version}"
  maintenance_window   = "${var.redis-maintenance-window}"
  node_type            = "${var.redis-instance-type}"
  num_cache_nodes      = "${var.redis-cache-nodes}"
  parameter_group_name = "${var.redis-parameter_group_name}"
  port                 = "6379"
  subnet_group_name    = "${aws_elasticache_subnet_group.aws-us-west2-preview-redis-subnet-grp.name}"
  security_group_ids   = ["${aws_security_group.aws-us-west2-preview-redis-sg.id}"]
  tags {
      Name = "${lookup(var.redis-name,count.index)}"
  }
  
}
