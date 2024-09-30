variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "jfrog-vpc"
}

variable "vpc_tenancy" {
  description = "Tenancy of the VPC"
  type        = string
  default     = "default"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_dns_support" {
  description = "Enable DNS support for the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for the VPC"
  type        = bool
  default     = true
}

# Updated to use only one public subnet
variable "pub_sub_name" {
  description = "Name of the public subnet"
  type        = string
  default     = "jfrog-pub-sub-01"
}

# Updated to a single CIDR for public subnet
variable "pub_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.0.0/18"
}

# Updated to use only one private subnet
variable "pvt_sub_name" {
  description = "Name of the private subnet"
  type        = string
  default     = "jfrog-pvt-sub-01"
}

# Updated to a single CIDR for private subnet
variable "pvt_cidr" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "10.0.128.0/18"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  type        = string
  default     = "jfrog-igw"
}

variable "nat_name" {
  description = "Name of the NAT Gateway"
  type        = string
  default     = "jfrog-nat"
}

# Updated to use a single public route table name
variable "pub_rt_name" {
  description = "Name for the public route table"
  type        = string
  default     = "jfrog-pub-rt-01"
}

# Updated to use a single private route table name
variable "pvt_rt_name" {
  description = "Name for the private route table"
  type        = string
  default     = "jfrog-pvt-rt-01"
}

variable "default_route_cidr_block" {
  description = "CIDR block for the default route (0.0.0.0/0)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "local_gateway_id" {
  description = "ID of the local gateway for the local route"
  type        = string
  default     = "local"
}

variable "vpc_peering_cidr_block" {
  description = "CIDR block for the VPC peering route"
  type        = string
  default     = "172.31.0.0/16"
}

variable "peering_vpc_id" {
  description = "ID of the peering VPC"
  type        = string
  default     = "vpc-02a507c401bdd43d8"
}

variable "auto_accept_peering" {
  description = "Automatically accept the VPC peering connection"
  type        = bool
  default     = true
}

variable "vpc_peering_name" {
  description = "Name for the VPC peering connection"
  type        = string
  default     = "jfrog-vpc-peering"
}

variable "route_table_id" {
  description = "ID of the route table"
  type        = string
  default     = "rtb-0f862e8b6a8439d43"
}
