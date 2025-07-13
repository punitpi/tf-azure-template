variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "southindia"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
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
      service_endpoints = ["Microsoft.Web"]
    }
  }
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
