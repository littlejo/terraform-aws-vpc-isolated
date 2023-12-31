variable "name" {
  description = "VPC name"
  type        = string
  default     = "my_vpc"
}

variable "cidr_block" {
  description = "VPC cidr"
  type        = string
}

variable "enable_dns_support" {
  description = "enable/disable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "enable/disable DNS hostnames in the VPC."
  type        = bool
  default     = false
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC. Default is default, which ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched. The only other option is dedicated, which ensures that EC2 instances launched in this VPC are run on dedicated tenancy instances regardless of the tenancy attribute specified at launch. This has a dedicated per region fee of $2 per hour, plus an hourly per instance usage fee."
  type        = string
  default     = "default"
}

variable "vpc_tags" {
  description = "A map of tags to assign to the VPC."
  type        = map(string)
  default     = {}
}

variable "global_tags" {
  description = "A map of tags to assign to all the resources."
  type        = map(string)
  default     = {}
}

variable "subnets" {
  description = "Object of subnets feature. If you don't mention az, it's the last character the key map, more information in example"
  type = map(object(
    {
      name               = string
      cidr_block         = string
      az                 = optional(string)
      tags               = optional(map(string), {})
      create_route_table = optional(bool, true)
      route_table_name   = optional(string, "")
      route_table_tags   = optional(map(string), {})
    })
  )
  default = {}
}

variable "security_groups" {
  description = "Feature of security groups"
  type = map(object(
    {
      name        = string
      description = optional(string, "A sg")
      ingress = list(object({
        description      = optional(string, "")
        port             = optional(number)
        from_port        = optional(number)
        to_port          = optional(number)
        protocol         = optional(string, "tcp")
        cidr_blocks      = optional(list(string), [])
        ipv6_cidr_blocks = optional(list(string), [])
        prefix_list_ids  = optional(list(string), [])
        self             = optional(bool, false)
        security_groups  = optional(list(string), [])
        }
        )
      )
      egress = optional(list(any))
      tags   = optional(map(string), {})
    })
  )
  default = {}
}
