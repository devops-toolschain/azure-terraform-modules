output "id" {
  description = "The Log Analytics Workspace ID."
  value       = "${azurerm_log_analytics_workspace.log_analytics_workspace.id}"
}

output "name" {
  description = "The name of the Log Analytics Workspace."
  value       = "${azurerm_log_analytics_workspace.log_analytics_workspace.name}"
}

output "primary_shared_key" {
  description = "The Primary shared key for the Log Analytics Workspace."
  value       = "${azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key}"
}

output "secondary_shared_key" {
  description = "The Secondary shared key for the Log Analytics Workspace."
  value       = "${azurerm_log_analytics_workspace.log_analytics_workspace.secondary_shared_key}"
}

output "workspace_id" {
  description = "The Workspace (or Customer) ID for the Log Analytics Workspace"
  value       = "${azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id}"
}

output "portal_url" {
  description = "The Portal URL for the Log Analytics Workspace."
  value       = "${azurerm_log_analytics_workspace.log_analytics_workspace.portal_url}"
}