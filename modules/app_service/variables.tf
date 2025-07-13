variable "app_service_name" {
  description = "Name of the app service"
  type        = string
}

variable "app_service_plan_name" {
  description = "Name of the app service plan"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "southindia"
}

variable "os_type" {
  description = "Operating system type"
  type        = string
  default     = "Linux"
  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "OS type must be either 'Linux' or 'Windows'."
  }
}

variable "sku_name" {
  description = "SKU name for the app service plan"
  type        = string
  default     = "F1"
  validation {
    condition = contains([
      "F1", "D1", "B1", "B2", "B3", "S1", "S2", "S3",
      "P1", "P2", "P3", "P1V2", "P2V2", "P3V2", "P1V3", "P2V3", "P3V3"
    ], var.sku_name)
    error_message = "SKU name must be a valid App Service Plan SKU."
  }
}

variable "always_on" {
  description = "Enable always on for the app service"
  type        = bool
  default     = false
}

variable "node_version" {
  description = "Node.js version for Linux app service"
  type        = string
  default     = "20-lts"
}

variable "dotnet_version" {
  description = ".NET version for Windows app service"
  type        = string
  default     = "v8.0"
}

variable "app_command_line" {
  description = "App command line for Linux app service"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "Development"
}

variable "app_settings" {
  description = "Map of app settings"
  type        = map(string)
  default = {
    "ENVIRONMENT" = "dev"
    "DEBUG"       = "true"
  }
}

variable "connection_string" {
  description = "Database connection string"
  type        = string
  default     = "Server=localhost;Database=myapp;Trusted_Connection=true;"
  sensitive   = true
}

variable "create_staging_slot" {
  description = "Create staging deployment slot"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
