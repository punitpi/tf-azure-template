# General Variables
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "myapp"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "myapp"
    ManagedBy   = "terraform"
  }
}

# Resource Group Variables
variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-myapp-dev"
}

# Virtual Network Variables
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "vnet-myapp-dev"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = list(string)
  }))
  default = {
    "default" = {
      address_prefixes  = ["10.0.1.0/24"]
      service_endpoints = []
    }
    "app-service" = {
      address_prefixes  = ["10.0.2.0/24"]
      service_endpoints = ["Microsoft.Web", "Microsoft.Storage"]
    }
  }
}

# Storage Account Variables
variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
  default     = "stmyappdev"
}

variable "storage_account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Storage replication type"
  type        = string
  default     = "LRS"
}

variable "storage_containers" {
  description = "Storage containers to create"
  type = map(object({
    access_type = string
  }))
  default = {
    "data" = {
      access_type = "private"
    }
    "logs" = {
      access_type = "private"
    }
    "backups" = {
      access_type = "private"
    }
  }
}

# Key Vault Variables
variable "key_vault_name" {
  description = "Name of the key vault"
  type        = string
  default     = "kv-myapp-dev"
}

variable "key_vault_sku" {
  description = "Key vault SKU"
  type        = string
  default     = "standard"
}

variable "create_sample_secrets" {
  description = "Whether to create sample secrets in key vault"
  type        = bool
  default     = true
}

variable "key_vault_secrets" {
  description = "Secrets to create in key vault"
  type        = map(string)
  default = {
    "database-password" = "P@ssw0rd123!"
    "api-key"           = "dev-api-key-12345"
    "storage-key"       = "dev-storage-key-67890"
  }
  sensitive = true
}

# App Service Variables
variable "app_service_name" {
  description = "Name of the app service"
  type        = string
  default     = "app-myapp-dev"
}

variable "app_service_plan_name" {
  description = "Name of the app service plan"
  type        = string
  default     = "plan-myapp-dev"
}

variable "app_service_os_type" {
  description = "App service OS type"
  type        = string
  default     = "Linux"
}

variable "app_service_sku" {
  description = "App service SKU"
  type        = string
  default     = "F1"
}

variable "app_service_always_on" {
  description = "Enable always on for app service"
  type        = bool
  default     = false
}

variable "app_service_settings" {
  description = "App service settings"
  type        = map(string)
  default = {
    "ENVIRONMENT"                  = "dev"
    "DEBUG"                        = "true"
    "WEBSITE_NODE_DEFAULT_VERSION" = "20-lts"
  }
}

variable "create_staging_slot" {
  description = "Create staging slot for app service"
  type        = bool
  default     = true
}
