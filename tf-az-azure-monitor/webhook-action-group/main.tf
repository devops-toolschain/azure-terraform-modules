resource "azurerm_monitor_action_group" "azure_monitor_action_group" {
  name                      = lower(replace(join("-", [var.company_code, var.tags["service"], var.tags["environment"], var.region_code, var.action_group_label]), " ", "-"))
  resource_group_name       = var.resource_group_name
  short_name                = var.azure_monitor_action_group_short_name

  webhook_receiver {
    name                    = var.web_hook_name
    service_uri             = var.web_hook_service_uri
    use_common_alert_schema = var.web_hook_use_common_alert_schema
  }
} 