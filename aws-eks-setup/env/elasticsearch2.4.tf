##################################################
## Elasticsearch 2.4
##################################################
data "template_file" "user_data" {
template = "${file("elastic2.4install.sh")}"
}
resource "aws_security_group" "us-west2-preview-es24-sg" {
  name        = "us-west2-preview-es24-sg"
  description = "Allow all inbound traffic"
  vpc_id = "${var.vpc-id}"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "aws-us-west2-preview-es24" {
    ami                         = "${lookup(var.es24-ami,var.aws_region)}"
    count                       = 2
    #vpc_id                      = "${aws_vpc.main.id}"
    subnet_id                   = "${var.public-subnets}"
    instance_type               = "t2.medium"
    key_name                    = "${var.key-name}"
    associate_public_ip_address = "true"
    vpc_security_group_ids      = ["${aws_security_group.us-west2-preview-es24-sg.id}"]
    #iam_instance_profile        = "${aws_iam_instance_profile.elastic-search-profile.name}"
    #security_groups             =  ["${aws_security_group.ec2-sg.name}"]
    user_data = "${data.template_file.user_data.template}"
    ebs_block_device {
            device_name = "/dev/sda1"
            volume_size = 50
            volume_type = "gp2"
            delete_on_termination = true
    }
    ebs_block_device {
            device_name = "/dev/sda1"
            volume_size = 50
            volume_type = "gp2"
            delete_on_termination = true
    }
    tags{
        Name        = "${var.application-name}-es24"
    }
    provisioner "file"{
        source = "/Users/nandanamvikas/Documents/aws-us-east2-preview-env/aws-us-east2-preview-env/elastic2.4install.sh"
        destination = "/tmp/elastic2.4install.sh"
    }
     provisioner "remote-exec" {
         inline =[ 
             "chmod +x /tmp/elastic2.4install.sh",
             "sudo /tmp/elastic2.4install.sh"
         ]
         
     }
     connection{
         type="ssh"
         user = "ec2-user"
         private_key = "${file("${var.key-path}")}"
     }
}