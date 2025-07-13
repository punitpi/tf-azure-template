# Resource Group
module "resource_group" {
  source = "../../modules/resource_group"

  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# Virtual Network
module "virtual_network" {
  source = "../../modules/virtual_network"

  vnet_name           = var.vnet_name
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
  subnets             = var.subnets
  tags                = var.tags

  depends_on = [module.resource_group]
}

# Storage Account
module "storage_account" {
  source = "../../modules/storage_account"

  storage_account_name = var.storage_account_name
  resource_group_name  = module.resource_group.resource_group_name
  location             = var.location
  account_tier         = var.storage_account_tier
  replication_type     = var.storage_replication_type
  containers           = var.storage_containers
  tags                 = var.tags

  depends_on = [module.resource_group]
}

# Key Vault
module "key_vault" {
  source = "../../modules/key_vault"

  key_vault_name        = var.key_vault_name
  resource_group_name   = module.resource_group.resource_group_name
  location              = var.location
  sku_name              = var.key_vault_sku
  create_sample_secrets = var.create_sample_secrets
  sample_secrets        = var.key_vault_secrets
  tags                  = var.tags

  depends_on = [module.resource_group]
}

# App Service
module "app_service" {
  source = "../../modules/app_service"

  app_service_name      = var.app_service_name
  app_service_plan_name = var.app_service_plan_name
  resource_group_name   = module.resource_group.resource_group_name
  location              = var.location
  os_type               = var.app_service_os_type
  sku_name              = var.app_service_sku
  always_on             = var.app_service_always_on
  app_settings          = var.app_service_settings
  create_staging_slot   = var.create_staging_slot
  tags                  = var.tags

  depends_on = [module.resource_group]
}
