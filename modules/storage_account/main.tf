resource "random_string" "storage_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_storage_account" "this" {
  name                     = "${var.storage_account_name}${random_string.storage_suffix.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
  account_kind             = var.account_kind

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public

  blob_properties {
    versioning_enabled = var.versioning_enabled

    delete_retention_policy {
      days = var.blob_retention_days
    }
  }

  tags = var.tags
}

resource "azurerm_storage_container" "containers" {
  for_each = var.containers

  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = each.value.access_type
}

# Create a sample blob for testing
resource "azurerm_storage_blob" "sample" {
  count = var.create_sample_blob ? 1 : 0

  name                   = "sample.txt"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.containers["data"].name
  type                   = "Block"
  source_content         = "This is a sample blob created by Terraform"
}
