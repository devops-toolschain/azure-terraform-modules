## tf-az-vm-linux-extensions

This module is used to install extensions for Linux Azure Virtual Machines.

NOTE: There are 5 extensions in this module and each of them can be enabled or disabled, by setting their respective "enabled" attribute to true or false.

# NOTE: This code supports only OS disk encryption. Data disk encryption is not supported because it depends on disk format which is specific to application.

***Note: This module requires azurerm provider 2.0.***

## Example Usage

Example linux-extension.tf file

```hcl
module "vm_extensions" {
    source                  = "../../modules/tf-az-vm-linux-extensions"
    template_file_path      = "../../modules/tf-az-vm-linux-extensions"
    virtual_machine_names   = [module.vm.vm_name]
    virtual_machine_ids     = [module.vm.vm_id]

    symantec_extension_config   = var.symantec_agent_config
    dependency_agent_extension  = var.dependency_agent_config
    linux_diagnostics_extension = var.diagnostic_agent_config
    rapid7_agent_extension      =  var.rapid7_agent_config
    disk_encryption_extension   =  var.disk_encryption_config

    log_analytics_workspace     = var.log_analytics_workspace
}
```

## Example Usage

Here are some of the object type variables that is used to pass values to the object variables.

```hcl
locals {
    vm_account_credentials = {
        admin_username = data.azurerm_key_vault_secret.admin_username.value
        admin_password = data.azurerm_key_vault_secret.admin_password.value
    }

    # This is how to use locals to pass values to object variables, declared in the module
    boot_diagnostics_config = {
        enabled     = true
        storage_uri = data.azurerm_storage_account.diagnostic_storage_account.primary_blob_endpoint
    }
    
    # Extension variables
    
    symantec_agent_config = {
        enabled               = true
        extension_name        = "symantec-agent"
        storage_account_name  = data.azurerm_storage_account.iac_storage_account.name
        storage_account_key   = data.azurerm_storage_account.iac_storage_account.primary_access_key
        primary_blob_endpoint = data.azurerm_storage_account.iac_storage_account.primary_blob_endpoint
    }

    disk_encryption_config = {
        enabled                 = true
        extension_name          = "disk-encryption"
        key_vault_url           = data.azurerm_key_vault.disk_encryption_key_vault.vault_uri
        key_vault_resource_id   = data.azurerm_key_vault.disk_encryption_key_vault.id
        key_encryption_key_url  = data.azurerm_key_vault_key.disk_encryption_key_vault_key.id
    }

    dependency_agent_config = {
        enabled         = true
        extension_name  = "dependency-agent-linux"
    }

    diagnostic_agent_config = {
        enabled                 = true
        extension_name          = "diagnostic-agent"
        metrics_storage_account = data.azurerm_storage_account.metrics_storage_account.name
        sas_token               = data.azurerm_storage_account.metrics_storage_account.primary_connection_string
    }

    rapid7_agent_config = {
        enabled         = true
        extension_name  = "rapid7-insight-agent-linux"
    }

    log_analytics_workspace = {
        workspace_id     = data.azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
        workspace_key    = data.azurerm_log_analytics_workspace.log_analytics_workspace.primary_shared_key
    }
```


## Argument Reference (Variables)

_Variables marked with [*] are mandatory and have to be specified or the module won't function._

 - `template_file_path`[*] - (Required) The relative path where the dependent files are stored.
 
 - `virtual_machine_names`[*] - (Required) A list of Virtual Machine names on which the extensions have to be installed.

 - `virtual_machine_ids`[*] - (Required) A list of Virtual Machine ids on which the extensions have to be installed.

- `disk_encryption_config` - (Optional) An object containing the values required for disk encryption extension. Available attributes are enabled, extension_name, key_vault_url, key_vault_resource_id and key_encryption_key_url.

- `diagnostic_agent_config` - (Optional) An object containing the values required for Diagnostics agent extension. Available attributes are enabled, extension_name, metrics_storage_account and sas_token

- `dependency_agent_config` - (Optional) An object containing the values required for dependency agent extension. Available attributes are enabled and extension_name.

- `symantec_agent_config` - (Optional) An object containing the values required for symantec agent extension. Available attributes are enabled, extension_name, storage_account_name, storage_account_key and primary_blob_endpoint

- `rapid7_agent_config` - (Optional) An object containing the values required for rapid7 agent extension. Available attributes are enabled and extension_name.
    
- `log_analytics_workspace` - (Optional) An object containing log analytics workspace id and key the values required for dependency agent extensions. Available attributes are workspace_id and workspace_key.

- `template_file_path`  - (Optional) The relative path of the template files with respect to the project folder.


## Attributes Reference (Outputs)

NONE


## Related STW Modules

`tf-az-vm-linux`


