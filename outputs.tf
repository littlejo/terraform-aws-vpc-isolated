output "id" {
  value = aws_vpc.this.id
}

output "subnet_ids" {
  value = [for m in module.subnets : m.id]
}

output "route_table_ids" {
  value = compact([for m in module.subnets : m.route_table_id])
}

output "summary" {
  value = [for m in module.subnets : m.summary]
}
