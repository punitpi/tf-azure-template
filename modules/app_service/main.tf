resource "azurerm_service_plan" "this" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name

  tags = var.tags
}

resource "azurerm_linux_web_app" "this" {
  count = var.os_type == "Linux" ? 1 : 0

  name                = var.app_service_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    always_on = var.always_on

    application_stack {
      node_version = var.node_version
    }

    app_command_line = var.app_command_line
  }

  app_settings = merge(var.app_settings, {
    "WEBSITE_NODE_DEFAULT_VERSION" = var.node_version
  })

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLServer"
    value = var.connection_string
  }

  tags = var.tags
}

resource "azurerm_windows_web_app" "this" {
  count = var.os_type == "Windows" ? 1 : 0

  name                = var.app_service_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    always_on = var.always_on

    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  app_settings = merge(var.app_settings, {
    "ASPNETCORE_ENVIRONMENT" = var.environment
  })

  connection_string {
    name  = "DefaultConnection"
    type  = "SQLServer"
    value = var.connection_string
  }

  tags = var.tags
}

# App Service Deployment Slot
resource "azurerm_linux_web_app_slot" "staging" {
  count = var.create_staging_slot && var.os_type == "Linux" ? 1 : 0

  name           = "staging"
  app_service_id = azurerm_linux_web_app.this[0].id

  site_config {
    always_on = var.always_on

    application_stack {
      node_version = var.node_version
    }
  }

  app_settings = var.app_settings

  tags = var.tags
}

resource "azurerm_windows_web_app_slot" "staging" {
  count = var.create_staging_slot && var.os_type == "Windows" ? 1 : 0

  name           = "staging"
  app_service_id = azurerm_windows_web_app.this[0].id

  site_config {
    always_on = var.always_on

    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  app_settings = var.app_settings

  tags = var.tags
}
