locals {
  id             = aws_subnet.this.id
  route_table_id = try(aws_route_table.this[0].id, null)
}

output "id" {
  value = local.id
}

output "route_table_id" {
  value = local.route_table_id
}

output "summary" {
  value = {
    subnet_name      = var.name
    subnet_id        = local.id
    route_table_id   = local.route_table_id
    route_table_name = local.route_table_name
  }
}
