locals {
  region = data.aws_region.this.name
}

data "aws_region" "this" {} #to find region for az

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy

  tags = merge(var.global_tags, var.vpc_tags, { Name = var.name })
}

module "subnets" {
  source             = "./modules/subnet"
  vpc_id             = aws_vpc.this.id
  for_each           = var.subnets
  name               = each.value.name
  cidr_block         = each.value.cidr_block
  availability_zone  = each.value.az == null ? "${local.region}${element(split("_", each.key), length(split("_", each.key)) - 1)}" : each.value.az
  tags               = each.value.tags
  create_route_table = each.value.create_route_table
  route_table_name   = each.value.route_table_name
  route_table_tags   = each.value.route_table_tags
  global_tags        = var.global_tags
}

module "security_groups" {
  source = "./modules/security-group"
  vpc_id = aws_vpc.this.id

  for_each    = var.security_groups
  name        = each.value.name
  description = each.value.description
  ingress     = each.value.ingress
  egress      = each.value.egress
  tags        = each.value.tags
}
