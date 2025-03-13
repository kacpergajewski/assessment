output "id" {
  value       = azurerm_postgresql_flexible_server.default.id
  description = "The ID of the PostgreSQL Flexible Server."
}

output "address" {
  value       = azurerm_postgresql_flexible_server.default.fqdn
  description = "Address of the database server created"
}