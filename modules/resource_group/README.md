# Resource Group Module

This module creates an Azure Resource Group.

## Usage

```hcl
module "resource_group" {
  source = "./modules/resource_group"

  resource_group_name = "rg-myapp-dev"
  location           = "southindia"
  tags = {
    Environment = "dev"
    Project     = "myapp"
  }
}
```
