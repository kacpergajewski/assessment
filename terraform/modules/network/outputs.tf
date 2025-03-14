output "id" {
  value       = azurerm_virtual_network.default.id
  description = "ID of the network created."
}

output "name" {
  value       = azurerm_virtual_network.default.name
  description = "The name of the virtual network."
}