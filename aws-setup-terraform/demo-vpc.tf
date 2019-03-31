
# Declare the AZ data source
# data "aws_availability_zones" "available" {}
data "aws_availability_zone" "demo-az" {
    name = "${var.region}c"
}

resource "aws_vpc" "demo-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Environment = "demo"
    }
}

# TODO: This is a single public subnet for everything, which
# isn't ideal.
#
# Start simple though <https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario1.html>
#
resource "aws_subnet" "demo-subnet" {
	vpc_id = "${aws_vpc.demo-vpc.id}"
    cidr_block = "10.0.0.0/16"
	map_public_ip_on_launch = true
    availability_zone_id = "${data.aws_availability_zone.demo-az.zone_id}"
	tags = {
  	    Environment = "demo"
	}
}

resource "aws_internet_gateway" "demo-internet-gateway" {
    vpc_id = "${aws_vpc.demo-vpc.id}"
	tags = {
  	    Environment = "demo"
	}
}

resource "aws_route" "demo-route" {
    route_table_id = "${aws_vpc.demo-vpc.main_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demo-internet-gateway.id}"
}

data "aws_vpc_endpoint_service" "s3" {
    service = "s3"
}

# needed for our lambda to comminicate with s3
resource "aws_vpc_endpoint" "s3" {
    vpc_id = "${aws_vpc.demo-vpc.id}"
    route_table_ids = ["${aws_vpc.demo-vpc.main_route_table_id}"]
    service_name = "${data.aws_vpc_endpoint_service.s3.service_name}"
}