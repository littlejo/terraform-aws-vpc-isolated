locals {
  ingress_tmp = [
    for ingress in var.ingress :
    strcontains(ingress.protocol, ",") ?
    [
      {
        from_port        = ingress.from_port == null ? ingress.port : ingress.from_port
        to_port          = ingress.to_port == null ? ingress.port : ingress.to_port
        protocol         = split(",", ingress.protocol)[0]
        cidr_blocks      = ingress.cidr_blocks
        ipv6_cidr_blocks = ingress.ipv6_cidr_blocks
        description      = ingress.description
        prefix_list_ids  = ingress.prefix_list_ids
        self             = ingress.self
        security_groups  = ingress.security_groups
      },
      {
        from_port        = ingress.from_port == null ? ingress.port : ingress.from_port
        to_port          = ingress.to_port == null ? ingress.port : ingress.to_port
        protocol         = split(",", ingress.protocol)[1]
        cidr_blocks      = ingress.cidr_blocks
        ipv6_cidr_blocks = ingress.ipv6_cidr_blocks
        description      = ingress.description
        prefix_list_ids  = ingress.prefix_list_ids
        self             = ingress.self
        security_groups  = ingress.security_groups
      }
    ]
    :
    [
      {
        from_port        = ingress.from_port == null ? ingress.port : ingress.from_port
        to_port          = ingress.to_port == null ? ingress.port : ingress.to_port
        protocol         = ingress.protocol
        cidr_blocks      = ingress.cidr_blocks
        ipv6_cidr_blocks = ingress.ipv6_cidr_blocks
        description      = ingress.description
        prefix_list_ids  = ingress.prefix_list_ids
        self             = ingress.self
        security_groups  = ingress.security_groups
      }
    ]
  ]

  ingress = flatten(local.ingress_tmp)

  egress_tmp = [
    for egress in var.egress :
    strcontains(egress.protocol, ",") ?
    [
      {
        from_port        = egress.from_port == null ? egress.port : egress.from_port
        to_port          = egress.to_port == null ? egress.port : egress.to_port
        protocol         = split(",", egress.protocol)[0]
        cidr_blocks      = egress.cidr_blocks
        ipv6_cidr_blocks = egress.ipv6_cidr_blocks
        description      = egress.description
        prefix_list_ids  = egress.prefix_list_ids
        self             = egress.self
        security_groups  = egress.security_groups
      },
      {
        from_port        = egress.from_port == null ? egress.port : egress.from_port
        to_port          = egress.to_port == null ? egress.port : egress.to_port
        protocol         = split(",", egress.protocol)[1]
        cidr_blocks      = egress.cidr_blocks
        ipv6_cidr_blocks = egress.ipv6_cidr_blocks
        description      = egress.description
        prefix_list_ids  = egress.prefix_list_ids
        self             = egress.self
        security_groups  = egress.security_groups
      }
    ]
    :
    [
      {
        from_port        = egress.from_port == null ? egress.port : egress.from_port
        to_port          = egress.to_port == null ? egress.port : egress.to_port
        protocol         = egress.protocol
        cidr_blocks      = egress.cidr_blocks
        ipv6_cidr_blocks = egress.ipv6_cidr_blocks
        description      = egress.description
        prefix_list_ids  = egress.prefix_list_ids
        self             = egress.self
        security_groups  = egress.security_groups
      }
    ]
  ]

  egress = flatten(local.egress_tmp)
}

resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ingress = local.ingress
  egress  = local.egress

  tags = merge({ Name = var.name }, var.tags)
}
