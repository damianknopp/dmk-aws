# boiler plate ec2 instances for kubespray
# #!/bin/bash
# terraform init
# terraform plan
# terraform apply -var-file="main.tfvars" modules/ec2

provider "aws" {
  region = "us-east-1"
}

variable "region" {
    default = "us-east-1"
}

variable "availability_zone" {
    default = "us-east-1b"
}

data "aws_availability_zone" "kube_az" {
    name = "${var.availability_zone}"
}

variable "worker_instance_type" {}

variable "pem_name" { }

variable "subnet_id" {}

data "aws_subnet" "kube_subnet" {
    id = "${var.subnet_id}"
}

variable "security_group_id" {}

data "aws_security_group" "kube_sg" {
    id = "${var.security_group_id}"
}

variable "iam_role_name" {}

# getRole permission problems
# data "aws_iam_role" "kube_iam" {
#   name = "${var.iam_role_name}"
# }

# search for latest image ami
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-*-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

variable "kube_tags" {
    type = "map" 
    default = {
        environment = "develop"
        "kubernetes.io/cluster/k8s" = "owned"
    } 
}

resource "aws_instance" "kube01-001" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.worker_instance_type
    availability_zone = data.aws_availability_zone.kube_az.id
    key_name = var.pem_name
    subnet_id = data.aws_subnet.kube_subnet.id
    iam_instance_profile = var.iam_role_name
    associate_public_ip_address = true
    security_groups = [ data.aws_security_group.kube_sg.id ]
    user_data = "${file("modules/ec2/user_data.sh")}"
    tags = merge(
        map("Name", "kube01-001"),
        map("kubespray-role", "kube-master,kube-node,etcd"),
        var.kube_tags)
}

resource "aws_instance" "kube01-002" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.worker_instance_type
    availability_zone = data.aws_availability_zone.kube_az.id
    key_name = var.pem_name
    subnet_id = data.aws_subnet.kube_subnet.id
    iam_instance_profile = var.iam_role_name
    associate_public_ip_address = true
    security_groups = [ data.aws_security_group.kube_sg.id ]
    user_data = "${file("modules/ec2/user_data.sh")}"
    tags = merge(
        map("Name", "kube01-002"),
        map("kubespray-role", "kube-master,kube-node,etcd"),
        var.kube_tags)
}

resource "aws_instance" "kube01-003" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.worker_instance_type
    availability_zone = data.aws_availability_zone.kube_az.id
    key_name = var.pem_name
    subnet_id = data.aws_subnet.kube_subnet.id
    iam_instance_profile = var.iam_role_name
    associate_public_ip_address = true
    security_groups = [ data.aws_security_group.kube_sg.id ]
    user_data = "${file("modules/ec2/user_data.sh")}"
    tags = merge(
        map("Name", "kube01-003"),
        map("kubespray-role", "kube-node,etcd"),
        var.kube_tags)
}