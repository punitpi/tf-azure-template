# Key Vault Module

This module creates an Azure Key Vault with access policies and sample secrets.

## Usage

```hcl
module "key_vault" {
  source = "./modules/key_vault"

  key_vault_name      = "kv-myapp-dev"
  resource_group_name = "rg-myapp-dev"
  location            = "southindia"

  sku_name                        = "standard"       # Optional
  enabled_for_disk_encryption     = true             # Optional
  enabled_for_deployment          = true             # Optional
  enabled_for_template_deployment = true             # Optional
  purge_protection_enabled        = false            # Optional
  soft_delete_retention_days      = 7                # Optional
  default_action                  = "Allow"          # Optional
  access_policies                 = {}               # Optional
  create_sample_secrets           = true             # Optional
  sample_secrets = {                                 # Optional
    "database-password" = "P@ssw0rd123!"
    "api-key"           = "sample-api-key-12345"
  }
  tags = {                                           # Optional
    Environment = "dev"
    Project     = "myapp"
  }
}
```
