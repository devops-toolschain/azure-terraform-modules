variable "vm_metric_alerts" {
  type        = map(any)
  description = "A list of VM metrick alerts"
}

variable "resource_group_name" {
  type        = string
  description = "Azure monitor metric alert resource group"
}

variable "azure_monitor_metric_alert_action_id" {
  type        = string
  description = "Azure monitor metric alert action id"
} 