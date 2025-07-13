output "app_service_plan_id" {
  description = "ID of the app service plan"
  value       = azurerm_service_plan.this.id
}

output "app_service_plan_name" {
  description = "Name of the app service plan"
  value       = azurerm_service_plan.this.name
}

output "app_service_id" {
  description = "ID of the app service"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.this[0].id : azurerm_windows_web_app.this[0].id
}

output "app_service_name" {
  description = "Name of the app service"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.this[0].name : azurerm_windows_web_app.this[0].name
}

output "app_service_hostname" {
  description = "Hostname of the app service"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.this[0].default_hostname : azurerm_windows_web_app.this[0].default_hostname
}

output "app_service_url" {
  description = "URL of the app service"
  value       = var.os_type == "Linux" ? "https://${azurerm_linux_web_app.this[0].default_hostname}" : "https://${azurerm_windows_web_app.this[0].default_hostname}"
}

output "outbound_ip_addresses" {
  description = "Outbound IP addresses"
  value       = var.os_type == "Linux" ? azurerm_linux_web_app.this[0].outbound_ip_addresses : azurerm_windows_web_app.this[0].outbound_ip_addresses
}

output "staging_slot_hostname" {
  description = "Hostname of the staging slot"
  value = var.create_staging_slot ? (
    var.os_type == "Linux" ?
    azurerm_linux_web_app_slot.staging[0].default_hostname :
    azurerm_windows_web_app_slot.staging[0].default_hostname
  ) : null
}
