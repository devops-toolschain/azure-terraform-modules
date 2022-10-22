resource "azurerm_monitor_action_group" "azure_monitor_action_group" {
  name                      = lower(replace(join("-", [var.company_code, var.tags["service"], var.tags["environment"], var.region_code, var.action_group_label]), " ", "-"))
  resource_group_name       = var.resource_group_name
  short_name                = var.azure_monitor_action_group_short_name

  email_receiver {
    name                    = var.email_receiver_name
    email_address           = var.email_receiver_email_address
    use_common_alert_schema = var.email_receiver_use_common_alert_schema
  }
} 