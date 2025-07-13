# Resource Group Outputs
output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.resource_group.resource_group_name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = module.resource_group.resource_group_id
}

# Virtual Network Outputs
output "vnet_id" {
  description = "ID of the virtual network"
  value       = module.virtual_network.vnet_id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = module.virtual_network.vnet_name
}

output "subnet_ids" {
  description = "Map of subnet IDs"
  value       = module.virtual_network.subnet_ids
}

# Storage Account Outputs
output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.storage_account.storage_account_name
}

output "storage_account_id" {
  description = "ID of the storage account"
  value       = module.storage_account.storage_account_id
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = module.storage_account.primary_blob_endpoint
}

# Key Vault Outputs
output "key_vault_id" {
  description = "ID of the key vault"
  value       = module.key_vault.key_vault_id
}

output "key_vault_name" {
  description = "Name of the key vault"
  value       = module.key_vault.key_vault_name
}

output "key_vault_uri" {
  description = "URI of the key vault"
  value       = module.key_vault.key_vault_uri
}

# App Service Outputs
output "app_service_id" {
  description = "ID of the app service"
  value       = module.app_service.app_service_id
}

output "app_service_name" {
  description = "Name of the app service"
  value       = module.app_service.app_service_name
}

output "app_service_url" {
  description = "URL of the app service"
  value       = module.app_service.app_service_url
}

output "app_service_hostname" {
  description = "Hostname of the app service"
  value       = module.app_service.app_service_hostname
}

output "staging_slot_hostname" {
  description = "Hostname of the staging slot"
  value       = module.app_service.staging_slot_hostname
}

# Summary Output
output "deployment_summary" {
  description = "Summary of deployed resources"
  value = {
    resource_group  = module.resource_group.resource_group_name
    virtual_network = module.virtual_network.vnet_name
    storage_account = module.storage_account.storage_account_name
    key_vault       = module.key_vault.key_vault_name
    app_service     = module.app_service.app_service_name
    app_service_url = module.app_service.app_service_url
    location        = var.location
    environment     = var.environment
  }
}
