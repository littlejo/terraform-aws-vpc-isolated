output "vpc_id" {
  value = module.vpc.id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "route_table_ids" {
  value = module.vpc.route_table_ids
}

output "summary" {
  value = module.vpc.summary
}
