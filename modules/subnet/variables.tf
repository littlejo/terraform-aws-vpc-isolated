variable "name" {
  description = "subnet name"
  type        = string
  default     = "sub-name"
}

variable "cidr_block" {
  description = "subnet cidr"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone of subnet"
  type        = string
}

variable "vpc_id" {
  description = "VPC id of the subnet"
  type        = string
}

variable "tags" {
  description = "a map of tags to assign to subnet."
  type        = map(string)
  default     = {}
}

variable "create_route_table" {
  description = "Create route table (one subnet for one route table)"
  type        = bool
  default     = true
}

variable "route_table_name" {
  description = "Route table name"
  type        = string
  default     = ""
}

variable "route_table_tags" {
  description = "a map of tags to assign to subnet."
  type        = map(string)
  default     = {}
}

variable "global_tags" {
  description = "A map of tags to assign to all the resources."
  type        = map(string)
  default     = {}
}
