output "id" {
  value = module.database.id
}

output "address" {
  value       = module.database.address
  description = "Address of the database server created"
}