resource "azurerm_monitor_metric_alert" "azure_monitor_metric_alert" {
  for_each = var.vm_metric_alerts
    name                = each.value["name"]
    resource_group_name = var.resource_group_name
    scopes              = each.value["scopes"]
    description         = each.value["description"]
    severity            = each.value["severity"]
    enabled             = each.value["enabled"]
    frequency           = each.value["frequency"]
    window_size         = each.value["window_size"]

    criteria {
      metric_namespace = each.value["metric_namespace"]
      metric_name      = each.value["metric_name"]
      aggregation      = each.value["aggregation"]
      operator         = each.value["operator"]
      threshold        = each.value["threshold"]

      dynamic "dimension" {
        for_each = each.value["dimension_name"] != null ? [1] : []
          content {
            name      = each.value["dimension_name"]
            operator  = each.value["dimension_operator"]
            values    = each.value["values"]
          }
      }
    }

    action {
      action_group_id = var.azure_monitor_metric_alert_action_id
    }
}
