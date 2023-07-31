locals {
  route_table_name = var.route_table_name == "" ? replace(var.name, "/^sub-/", "rtb-") : var.route_table_name
}

resource "aws_subnet" "this" {
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone
  vpc_id            = var.vpc_id
  tags              = merge(var.global_tags, var.tags, { Name = var.name })
}

resource "aws_route_table" "this" {
  count  = var.create_route_table ? 1 : 0
  vpc_id = var.vpc_id
  tags   = merge(var.global_tags, var.route_table_tags, { Name = local.route_table_name })
}

resource "aws_route_table_association" "this" {
  count          = var.create_route_table ? 1 : 0
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this[0].id
}
