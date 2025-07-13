output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.this.name
}

output "resource_group_id" {
  description = "ID of the created resource group"
  value       = azurerm_resource_group.this.id
}

output "location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.this.location
}
