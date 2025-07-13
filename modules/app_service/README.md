# App Service Module

This module creates an Azure App Service with App Service Plan and optional staging slot.

## Usage

```hcl
module "app_service" {
  source = "./modules/app_service"

  app_service_name      = "app-myapp-dev"
  app_service_plan_name = "plan-myapp-dev"
  resource_group_name   = "rg-myapp-dev"
  location              = "southindia"

  os_type             = "Linux"                              # Optional
  sku_name            = "F1"                                 # Optional
  always_on           = false                                # Optional
  node_version        = "20-lts"                             # Optional
  dotnet_version      = "v8.0"                               # Optional
  app_command_line    = ""                                   # Optional
  environment         = "Development"                        # Optional
  app_settings        = {                                    # Optional
    "ENVIRONMENT" = "dev"
    "DEBUG"       = "true"
  }
  connection_string   = "Server=localhost;Database=myapp;Trusted_Connection=true;"  # Optional
  create_staging_slot = true                                  # Optional
  tags = {                                                    # Optional
    Environment = "dev"
    Project     = "myapp"
  }
}
```
