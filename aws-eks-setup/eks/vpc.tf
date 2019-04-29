#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "aws-us-west2-preview" {
  cidr_block = "10.0.0.0/16"

  tags = "${
    map(
     "Name", "terraform-eks-aws-us-west2-preview-node",
     "kubernetes.io/cluster/${var.application-name}", "shared",
    )
  }"
}

resource "aws_subnet" "aws-us-west2-preview" {
  count = 2

  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = "${aws_vpc.aws-us-west2-preview.id}"

  tags = "${
    map(
     "Name", "terraform-eks-aws-us-west2-preview-node",
     "kubernetes.io/cluster/${var.application-name}", "shared",
    )
  }"
}
resource "aws_subnet" "aws-us-west2-preview-private-1" {
    vpc_id = "${aws_vpc.aws-us-west2-preview.id}"
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    #availability_zone = "us-east-2a"

    tags {
        Name = "${var.application-name}-private-subnet-1"
    }
}
resource "aws_subnet" "aws-us-west2-preview-private-2" {
    vpc_id = "${aws_vpc.aws-us-west2-preview.id}"
    cidr_block = "10.0.5.0/24"
    map_public_ip_on_launch = "false"
    #availability_zone = "us-east-2b"

    tags {
        Name = "${var.application-name}-private-subnet-2"
    }
}

resource "aws_internet_gateway" "aws-us-west2-preview" {
  vpc_id = "${aws_vpc.aws-us-west2-preview.id}"

  tags {
    Name = "terraform-eks-aws-us-west2-preview"
  }
}

resource "aws_route_table" "aws-us-west2-preview" {
  vpc_id = "${aws_vpc.aws-us-west2-preview.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.aws-us-west2-preview.id}"
  }
}

resource "aws_route_table_association" "aws-us-west2-preview" {
  count = 2

  subnet_id      = "${aws_subnet.aws-us-west2-preview.*.id[count.index]}"
  route_table_id = "${aws_route_table.aws-us-west2-preview.id}"
}
resource "aws_subnet" "aws-us-west2-preview-public-subnet" {
    vpc_id = "${aws_vpc.aws-us-west2-preview.id}"
    cidr_block = "10.0.6.0/24"
    map_public_ip_on_launch = "false"
    #availability_zone = "us-east-2a"

    tags {
        Name = "${var.application-name}-public-subnet-1"
    }
}

resource "aws_route_table_association" "aws-us-west2-preview-rt-subnet-assoc-public" {
  count = 1

  subnet_id      = "${aws_subnet.aws-us-west2-preview-public-subnet.id}"
  route_table_id = "${aws_route_table.aws-us-west2-preview.id}"
}
