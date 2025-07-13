output "key_vault_id" {
  description = "ID of the created key vault"
  value       = azurerm_key_vault.this.id
}

output "key_vault_name" {
  description = "Name of the created key vault"
  value       = azurerm_key_vault.this.name
}

output "key_vault_uri" {
  description = "URI of the created key vault"
  value       = azurerm_key_vault.this.vault_uri
}

output "key_vault_tenant_id" {
  description = "Tenant ID of the key vault"
  value       = azurerm_key_vault.this.tenant_id
}

output "secret_names" {
  description = "Names of created secrets"
  value       = keys(azurerm_key_vault_secret.sample_secrets)
}
