variable "storage_account_name" {
  description = "Base name of the storage account (will have random suffix)"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]{3,21}$", var.storage_account_name))
    error_message = "Storage account name must be between 3 and 21 characters, lowercase letters and numbers only."
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

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Account tier must be either Standard or Premium."
  }
}

variable "replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"
  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.replication_type)
    error_message = "Replication type must be one of: LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  }
}

variable "account_kind" {
  description = "Storage account kind"
  type        = string
  default     = "StorageV2"
  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.account_kind)
    error_message = "Account kind must be one of: BlobStorage, BlockBlobStorage, FileStorage, Storage, StorageV2."
  }
}

variable "allow_nested_items_to_be_public" {
  description = "Allow nested items to be public"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enable blob versioning"
  type        = bool
  default     = true
}

variable "blob_retention_days" {
  description = "Number of days to retain deleted blobs"
  type        = number
  default     = 7
}

variable "containers" {
  description = "Map of storage containers to create"
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
  }
}

variable "create_sample_blob" {
  description = "Create a sample blob for testing"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
