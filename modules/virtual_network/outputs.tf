output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Map of subnet names to their IDs"
  value       = { for k, v in azurerm_subnet.subnets : k => v.id }
}

output "subnet_names" {
  description = "Map of subnet names"
  value       = { for k, v in azurerm_subnet.subnets : k => v.name }
}

output "nsg_id" {
  description = "ID of the network security group"
  value       = azurerm_network_security_group.this.id
}
