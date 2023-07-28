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

resource "aws_subnet" "this" {
  for_each = var.subnets

  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az == null ? "${local.region}${element(split("_", each.key), length(split("_", each.key)) - 1)}" : each.value.az
  vpc_id            = aws_vpc.this.id
  tags              = merge(var.global_tags, var.subnets_tags, each.value.tags, { Name = each.value.name })
}
