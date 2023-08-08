variable "name" {
  description = "(Required) Name of the security group"
  type        = string
}

variable "description" {
  description = "(Required) Description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "(Optional) VPC id of the security group (by default, default vpc id)"
  type        = string
  default     = null
}

variable "ingress" {
  description = <<EOF
(Optional) Ingress rules of the security group. Default ingress is described on ingress_default variable

(Optional) description - description of the rule - string
(Optional) protocol - protocol to use ("tcp", "udp", "icmp", "-1" for all). If "-1", you need to use "port = 0" - string
(Optional) port - port number to open - number
(Optional) from_port - begin of port range (do not use from_port and port at the same time) - number
(Optional) to_port - end of port range (do not use to_port and port at the same time) - number
(Optional) cidr_blocks - cidr list - list(string)
(Optional) ipv6_cidr_blocks - cidr list in IPv6 - list(string)
(Optional) prefix_list_ids - list of ids of prefix list - list(string)
(Optional) security_groups - list(string)
(Optional) self - if this security group is include in this rule - bool
EOF
  type = list(object(
    {
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
  ))
}

variable "egress" {
  description = "(Optional) Egress rules of the security group"
  type = list(object(
    {
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
  ))
  default = [{
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    description      = "egress"
    prefix_list_ids  = null
    self             = false
    security_groups  = []
  }]
}

variable "tags" {
  description = "Tags of the security group"
  type        = map(any)
  default     = {}
}
