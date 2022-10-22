resource "azurerm_virtual_machine_extension" "symantec_extension_config" {
  count                       = var.symantec_agent_config.enabled ? length(var.virtual_machine_ids) : 0
  name                        = lower(replace(join("-", [var.virtual_machine_names[count.index], var.symantec_agent_config.extension_name]), " ", ""))
  virtual_machine_id          = var.virtual_machine_ids[count.index]
  auto_upgrade_minor_version  = true
  publisher                   = var.symantec_agent_provider_config["publisher"]
  type                        = var.symantec_agent_provider_config["type_os_encryption"]
  type_handler_version        = var.symantec_agent_provider_config["type_handler_version"]
  settings                    = data.template_file.symantec_settings.rendered
  protected_settings          = data.template_file.symantec_protected_settings.rendered
}

resource "azurerm_virtual_machine_extension" "dependency_agent_extension" {
  count                       = var.dependency_agent_config.enabled ? length(var.virtual_machine_names) : 0
  name                        = lower(replace(join("-", [var.virtual_machine_names[count.index], var.dependency_agent_config.extension_name]), " ", ""))
  virtual_machine_id          = var.virtual_machine_ids[count.index]
  auto_upgrade_minor_version  = true
  publisher                   = var.dependency_agent_provider_config["publisher"]
  type                        = var.dependency_agent_provider_config["type_os_encryption"]
  type_handler_version        = var.dependency_agent_provider_config["type_handler_version"]
  settings                    = jsonencode(map("workspaceId", var.log_analytics_workspace.workspace_id))
  protected_settings          = jsonencode(map("workspaceKey", var.log_analytics_workspace.workspace_key))
  depends_on                  = [azurerm_virtual_machine_extension.symantec_extension_config]
 }

resource "azurerm_virtual_machine_extension" "linux_diagnostics_extension" {
  count                       = var.diagnostic_agent_config.enabled ? length(var.virtual_machine_ids) : 0
  name                        = lower(replace(join("-", [var.virtual_machine_names[count.index], var.diagnostic_agent_config.extension_name]), " ", ""))
  virtual_machine_id          = var.virtual_machine_ids[count.index]
  auto_upgrade_minor_version  = true
  publisher                   = var.diagnostic_agent_provider_config["publisher"]
  type                        = var.diagnostic_agent_provider_config["type_os_encryption"]
  type_handler_version        = var.diagnostic_agent_provider_config["type_handler_version"]
  settings                    = data.template_file.diagnostic_settings.rendered
  protected_settings          = data.template_file.diagnostic_protected_settings.rendered
  depends_on                  = [azurerm_virtual_machine_extension.dependency_agent_extension]
}

resource "azurerm_virtual_machine_extension" "rapid7_agent_extension" {
  count                       = var.rapid7_agent_config.enabled ? length(var.virtual_machine_names) : 0
  name                        = lower(replace(join("-", [var.virtual_machine_names[count.index], var.rapid7_agent_config.extension_name]), " ", ""))
  virtual_machine_id          = var.virtual_machine_ids[count.index]
  auto_upgrade_minor_version  = true
  publisher                   = var.rapid7_agent_provider_config["publisher"]
  type                        = var.rapid7_agent_provider_config["type_os_encryption"]
  type_handler_version        = var.rapid7_agent_provider_config["type_handler_version"]
  settings                    = data.template_file.rapid7_json.rendered
  protected_settings          = data.template_file.rapid7_json.rendered
  depends_on                  = [azurerm_virtual_machine_extension.linux_diagnostics_extension]
}

resource "azurerm_virtual_machine_extension" "disk_encryption_extension" {
  count                       = var.disk_encryption_config.enabled ? length(var.virtual_machine_names) : 0
  name                        = lower(replace(join("-", [var.virtual_machine_names[count.index], var.disk_encryption_config.extension_name]), " ", ""))
  virtual_machine_id          = var.virtual_machine_ids[count.index]
  auto_upgrade_minor_version  = true
  publisher                   = var.disk_encryption_provider_config["publisher"]
  type                        = var.disk_encryption_provider_config["type_os_encryption"]
  type_handler_version        = var.disk_encryption_provider_config["type_handler_version"]
  settings                    = data.template_file.disk_encryption.rendered
  depends_on                  = [azurerm_virtual_machine_extension.rapid7_agent_extension]
}