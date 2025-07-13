# Storage Account Module

This module creates an Azure Storage Account with containers and optional sample blob.

## Usage

```hcl
module "storage_account" {
  source = "./modules/storage_account"

  storage_account_name = "mystorageaccount"
  resource_group_name  = "rg-myapp-dev"
  location             = "southindia"

  account_tier         = "Standard"         # Optional
  replication_type     = "LRS"              # Optional
  account_kind         = "StorageV2"        # Optional
  allow_nested_items_to_be_public = false   # Optional
  versioning_enabled   = true               # Optional
  blob_retention_days  = 7                  # Optional
  create_sample_blob   = true               # Optional

  containers = {
    "data" = {
      access_type = "private"
    }
    "logs" = {
      access_type = "private"
    }
  }

  tags = {
    Environment = "dev"
    Project     = "myapp"
  }
}
```
