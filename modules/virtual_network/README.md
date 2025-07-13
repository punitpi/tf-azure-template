# Virtual Network Module

This module creates an Azure Virtual Network with subnets and network security groups.

## Usage

```hcl
module "virtual_network" {
  source = "./modules/virtual_network"

  vnet_name           = "vnet-myapp-dev"
  resource_group_name = "rg-myapp-dev"
  location           = "southindia"
  address_space      = ["10.0.0.0/16"]

  subnets = {
    "default" = {
      address_prefixes  = ["10.0.1.0/24"]
      service_endpoints = []
    }
    "app-service" = {
      address_prefixes  = ["10.0.2.0/24"]
      service_endpoints = ["Microsoft.Web"]
    }
  }

  tags = {
    Environment = "dev"
    Project     = "myapp"
  }
}
```
