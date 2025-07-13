data "azurerm_client_config" "current" {}

resource "random_string" "keyvault_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_key_vault" "this" {
  name                = "${var.key_vault_name}-${random_string.keyvault_suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.sku_name

  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_template_deployment = var.enabled_for_template_deployment
  purge_protection_enabled        = var.purge_protection_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days

  network_acls {
    default_action = var.default_action
    bypass         = "AzureServices"
  }

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "current_user" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Create",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Update",
    "GetRotationPolicy",
    "SetRotationPolicy"
  ]

  secret_permissions = [
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Set"
  ]

  certificate_permissions = [
    "Create",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Update"
  ]
}

resource "azurerm_key_vault_access_policy" "additional_policies" {
  for_each = var.access_policies

  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value.object_id

  key_permissions         = each.value.key_permissions
  secret_permissions      = each.value.secret_permissions
  certificate_permissions = each.value.certificate_permissions
}

# Create sample secrets - using locals to handle sensitive values
locals {
  # Convert sensitive variable to local to use in for_each
  secrets_to_create = var.create_sample_secrets ? var.sample_secrets : {}
}

resource "azurerm_key_vault_secret" "sample_secrets" {
  for_each = nonsensitive(local.secrets_to_create)

  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.this.id

  depends_on = [azurerm_key_vault_access_policy.current_user]
}
