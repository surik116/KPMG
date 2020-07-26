variable "name" {}

variable "cidr" {}

variable "public_subnets" {
  type = list(string)
  description = "A list of public subnets inside the VPC."
  default     = []
}

variable "private_subnets" {
  type = list(string)
  description = "A list of private subnets inside the VPC."
  default     = []
}

variable "database_subnets" {
  type        = list(string)
  description = "A list of database subnets"
  default     = []
}

variable "webapp_subnets" {
  type        = list(string)
  description = "A list of elasticache subnets"
  default     = []
}

variable "elb_subnets" {
  type = list(string)
  description = "A list of ELB subnets inside the VPC."
  default     = []
}

variable "azs" {
  type = list(string)
  description = "A list of Availability zones in the region"
  default     = []
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = false
}

variable "map_public_ip_on_launch" {
  description = "should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

variable "private_propagating_vgws" {
  type = list(string)
  description = "A list of VGWs the private route table should propagate."
  default     = []
}

variable "public_propagating_vgws" {
  type = list(string)
  description = "A list of VGWs the public route table should propagate."
  default     = []
}

variable "tags" {
  type = map(string)
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "public_subnet_tags" {
  type = map(string)
  description = "Additional tags for the public subnets"
  default     = {}
}

variable "private_subnet_tags" {
  type = map(string)
  description = "Additional tags for the public subnets"
  default     = {}
}

variable "database_subnet_tags" {
  type = map(string)
  description = "Additional tags for the database subnets"
  default     = {}
}

variable "webapp_subnet_tags" {
  type = map(string)
  description = "Additional tags for the elasticache subnets"
  default     = {}
}

variable "elb_subnet_tags" {
  type = map(string)
  description = "Additional tags for the public subnets"
  default     = {}
}