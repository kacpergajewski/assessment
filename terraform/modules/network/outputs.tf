output "id" {
  value       = azurerm_virtual_network.default.id
  description = "ID of the network created."
}

output "name" {
  value       = azurerm_virtual_network.default.name
  description = "The name of the virtual network."
}

# output "database_subnet_id" {
#   value = tostring({
#     for s in azurerm_subnet.default : s.name => s.id
#     if s.delegation[*].service_delegation[*].name == "Microsoft.DBforPostgreSQL/flexibleServers"
#   })
#   description = "IDs of subnets with delegation 'Microsoft.DBforPostgreSQL/flexibleServers'."
# }
