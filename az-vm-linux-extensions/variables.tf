variable "virtual_machine_names" {
  type        = list(string)
  description = "The Virtual machine names"
}

variable "virtual_machine_ids" {
  type        = list(string)
  description = "The Virtual machine ids"
}

# Disk Encryption variables
variable "disk_encryption_config" {
  type = object({
    enabled                = bool
    extension_name         = string
    key_vault_url          = string
    key_vault_resource_id  = string
    key_encryption_key_url = string
  })
  default = {
    enabled                = false
    extension_name         = ""
    key_vault_url          = ""
    key_vault_resource_id  = ""
    key_encryption_key_url = ""
  }
  description = "The Key Vault settngs for Disk Encryption"
}

variable "disk_encryption_provider_config" {
  type = map(string)
  default = {
    encryption_operation = "EnableEncryption"
    publisher            = "Microsoft.Azure.Security"
    type_os_encryption   = "AzureDiskEncryptionForLinux"
    type_handler_version = "1.1"
  }
}
# Disk Encryption variables

##### Shared variable for Dependency and OMS agent #####
variable "log_analytics_workspace" {
  type = object({
    workspace_id  = string
    workspace_key = string
  })
  default = {
    workspace_id  = ""
    workspace_key = ""
  }
  description = "The log analytics workspace id and key for dependency and monitoring agent extensions."
}
##### Shared variable for Dependency and OMS agent #####

# Dependency Agent variables
variable "dependency_agent_config" {
  type = object({
    enabled        = bool
    extension_name = string
  })
  default = {
    enabled        = false
    extension_name = ""
  }
  description = "The dependency agent settings"
}

variable "dependency_agent_provider_config" {
  type = map(string)
  default = {
    publisher            = "Microsoft.Azure.Monitoring.DependencyAgent"
    type_os_encryption   = "DependencyAgentLinux"
    type_handler_version = "9.5"
  }
}
# Dependency Agent variables

# Rapid7 Agent variables
variable "rapid7_agent_config" {
  type = object({
    enabled        = bool
    extension_name = string
  })
  default = {
    enabled        = false
    extension_name = ""
  }
  description = "The rapid7 agent settings"
}

variable "rapid7_agent_provider_config" {
  type = map(string)
  default = {
    publisher            = "Rapid7.InsightPlatform"
    type_os_encryption   = "InsightAgentLinux"
    type_handler_version = "2.0"
  }
}
# Rapid7 Agent variables

# Diagnostic agent variables
variable "diagnostic_agent_config" {
  type = object({
    enabled                 = bool
    extension_name          = string
    metrics_storage_account = string
    sas_token               = string
  })
  default = {
    enabled                 = false
    extension_name          = ""
    metrics_storage_account = ""
    sas_token               = ""
  }
  description = "The Linux diagnostic agent settings"
}

variable "diagnostic_agent_provider_config" {
  type = map(string)
  default = {
    publisher            = "Microsoft.Azure.Diagnostics"
    type_os_encryption   = "LinuxDiagnostic"
    type_handler_version = "3.0"
  }
}
# Diagnostic agent variables

# Symantec agent variables
variable "symantec_agent_config" {
  type = object({
    enabled               = bool
    extension_name        = string
    storage_account_name  = string
    storage_account_key   = string
    primary_blob_endpoint = string    
  })
  default = {
    enabled               = false
    extension_name        = ""
    storage_account_name  = ""
    storage_account_key   = ""
    primary_blob_endpoint = ""
  }
  description = "The Linux diagnostic agent settings"
} 

variable "symantec_files" {
  type        = list(string)
  default     = ["linux-pre-config-management/sep_linux_install.sh", "linux-pre-config-management/SymantecEndpointProtection.zip"]
  description = "(Optional) A list of files required to be downloaded on the server. The files path will be prefixed with 'https://<STORAGE ACCOUNT URL>/'."
}

variable "symantec_command_to_execute" {
  type        = string
  default     = "sh sep_linux_install.sh"
  description = "(Optional) The command to execute by the extension."
}

variable "symantec_agent_provider_config" {
  type = map(string)
  default = {
    publisher            = "Microsoft.Azure.Extensions"
    type_os_encryption   = "CustomScript"
    type_handler_version = "2.1"
  }
}
# Symantec agent variables

variable "template_file_path" {
  type        = string
  description = "The relative path of the template files with respect to the project folder"
}