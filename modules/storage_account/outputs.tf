output "storage_account_name" {
  description = "Name of the created storage account"
  value       = azurerm_storage_account.this.name
}

output "storage_account_id" {
  description = "ID of the created storage account"
  value       = azurerm_storage_account.this.id
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "primary_access_key" {
  description = "Primary access key"
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "connection_string" {
  description = "Storage account connection string"
  value       = azurerm_storage_account.this.primary_connection_string
  sensitive   = true
}

output "container_names" {
  description = "Names of created containers"
  value       = keys(azurerm_storage_container.containers)
}
