variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

### Variable to enable/disable Maxscale 2 from being deployed
variable "deploy_maxscale2" {
  description = "When true a 2nd maxscale instance will be deployed"
  default = false
}

variable "deploy_loadtest" {
  description = "When true an additional node will be deployed for load generation"
  default = false
}

###  Put in the name of an existing EC2 key (without the .pem)
variable "keyname" {
  description = "AWS Key to be used"
  default     = "test"
}

### Put in the path and filename of the EC2 keyname listed above
variable "keypath" {
  description = "Path to AWS key"
  default     = "~/Downloads/test.pem"
}

variable "public_subnet_cidr1" {
  description = "CIDR for the public subnet"
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr1" {
  description = "CIDR for the private subnet"
  default = "10.0.2.0/24"
}

variable "private_subnet_cidr2" {
  description = "CIDR for the private subnet"
  default = "10.0.3.0/24"
}

variable "private_subnet_cidr3" {
  description = "CIDR for the private subnet"
  default = "10.0.4.0/24"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-011b3ccf1bd6db744"
#  default = "ami-035be7bafff33b6b6"
}

variable "az1" {
  description = "Availability Zone #1"
  default = "us-east-1a"
}

variable "az2" {
  description = "Availability Zone #2"
  default = "us-east-1b"
}
variable "az3" {
  description = "Availability Zone #2"
  default = "us-east-1c"
}

variable "dbinstancetype" {
  description = "Instance type for Databases"
  default = "i3.large"
}

variable "maxscaleinstancetype" {
  description = "Instance type for Maxscale"
  default = "i3.large"
}

variable "bastioninstancetype" {
  description = "Bastion Instance type"
  default = "t2.micro"
}
variable "loadtestinstancetype" {
  description = "Instance Type used for load testing"
  default = "t2.micro"
}
