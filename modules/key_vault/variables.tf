variable "key_vault_name" {
  description = "Base name of the key vault (will have random suffix)"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{1,22}[a-zA-Z0-9]$", var.key_vault_name))
    error_message = "Key vault name must be 3-24 characters, start with a letter, and contain only letters, numbers, and hyphens."
  }
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

variable "sku_name" {
  description = "SKU name for the key vault"
  type        = string
  default     = "standard"
  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "SKU name must be either 'standard' or 'premium'."
  }
}

variable "enabled_for_disk_encryption" {
  description = "Enable key vault for disk encryption"
  type        = bool
  default     = true
}

variable "enabled_for_deployment" {
  description = "Enable key vault for deployment"
  type        = bool
  default     = true
}

variable "enabled_for_template_deployment" {
  description = "Enable key vault for template deployment"
  type        = bool
  default     = true
}

variable "purge_protection_enabled" {
  description = "Enable purge protection"
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "Number of days to retain deleted items"
  type        = number
  default     = 7
  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "Soft delete retention days must be between 7 and 90."
  }
}

variable "default_action" {
  description = "Default action for network ACLs"
  type        = string
  default     = "Allow"
  validation {
    condition     = contains(["Allow", "Deny"], var.default_action)
    error_message = "Default action must be either 'Allow' or 'Deny'."
  }
}

variable "access_policies" {
  description = "Map of additional access policies"
  type = map(object({
    object_id               = string
    key_permissions         = list(string)
    secret_permissions      = list(string)
    certificate_permissions = list(string)
  }))
  default = {}
}

variable "create_sample_secrets" {
  description = "Whether to create sample secrets"
  type        = bool
  default     = true
}

variable "sample_secrets" {
  description = "Map of sample secrets to create"
  type        = map(string)
  default = {
    "database-password" = "P@ssw0rd123!"
    "api-key"           = "sample-api-key-12345"
  }
  sensitive = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
