## tf-az-vm-linux

This module is for creating a Linux Azure Virtual Machine.

***Note: This module requires azurerm provider 2.0.***

## Example Usage

Example vm.tf file:

```hcl
module "vm" {
    source                             = "../../modules/tf-az-vm-linux"
    resource_group_name                = data.azurerm_resource_group.resource_group.name
    location                           = data.azurerm_resource_group.resource_group.location
    vm_name                            = var.vm_name
    vm_size                            = var.vm_size
    delete_os_disk_on_termination      = var.delete_os_disk_on_termination
    delete_data_disks_on_termination   = var.delete_data_disks_on_termination
    network_interface_ids              = [module.vm_nic.id]
    #zones                             = ["1"] # Zones must not be set if availability set is required
    #availability_set_id               = module.vm_availability_set.id
    #proximity_placement_group_id      = module.vm_ppg.id

    storage_os_disk                    = var.storage_os_disk
    storage_data_disk                  = var.storage_data_disk
    storage_image_reference            = var.storage_image_reference
    os_profile                         = var.vm_account_credentials
    os_profile_linux_config            = var.disable_password_authentication
    boot_diagnostics                   = var.boot_diagnostics_config.enabled
    tags                               = var.tags
}
```

The required tags should be populated as lowercase text in the variables.tf file within the execution folder.

Example variables.tf file:

```hcl
# Reminder - all tags should be in lowercase

variable "tags" {
  type = map(string)
  default  = {
    service                = "linvmpoc4"
    servicehours           =  "24*7"
    iacversion             = "N/A"
    expireson              = "N/A"
    description            = "testing server"
    maintenancewindow      = "N/A"
    hoursofoperation       = "N/A"
    serviceclassification  = "N/A"
    businessowner          =  "N/A"
    costcentre             = "N/A"
    project                = "poc"
    department             = "N/A"
    confidentiality        = "N/A"
    compliance             = "N/A"
  }
}
```

## Here are some of the object type variables.

```hcl
locals {
  vm_account_credentials = {
      admin_username = data.azurerm_key_vault_secret.admin_username.value
      admin_password = data.azurerm_key_vault_secret.admin_password.value
  }

  boot_diagnostics_config = {
      enabled     = true
      storage_uri = data.azurerm_storage_account.diagnostic_storage_account.primary_blob_endpoint
  }
}

## This variable can store OS configuration for devtest VM. Useful when workspace is used.
variable "storage_os_disk" {
    type = map(object({
        caching             = string
        create_option       = string
        managed_disk_type   = string
        os_type             = string
        os_disk_size        = string
    }))
    
    default = {
        devtest = {
            caching           = "ReadWrite"
            create_option     = "FromImage"
            managed_disk_type = "StandardSSD_LRS"
            os_type           = "Linux"
            os_disk_size      = "127"
        }
    }
}

## This variable can store data disk configuration for devtest VM. Useful when workspace is used.
variable "storage_data_disk" {
    type = map(list(object({
        caching           = string
        create_option     = string
        disk_size_gb      = string
        managed_disk_type = string
    })))
    default     = {
        devtest = [
            {
                caching           = "None"
                create_option     = "Empty"
                disk_size_gb      = "32"
                managed_disk_type = "StandardSSD_LRS"
            },
            {
                caching           = "ReadOnly"
                create_option     = "Empty"
                disk_size_gb      = "32"
                managed_disk_type = "StandardSSD_LRS"
            }
        ]
    } 
}

variable "storage_image_reference" {
    type = object({
        publisher   = string
        offer       = string
        sku         = string
        version     = string
    })
    default = {
        publisher = "RedHat"
        offer     = "RHEL"
        sku       = "7.6"
        version   = "7.6.2019102813"
    }
}
```

## Argument Reference (Variables)

_Variables marked with [*] are mandatory and have to be specified or the module won't function._

 - `resource_group_name`[*] - (Required) Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created.
 
 - `location`[*] - (Required) Specifies the Azure Region where the Virtual Machine exists. Changing this forces a new resource to be created.

 - `vm_name`[*] - (Required) Specifies the name of the Virtual Machine. Changing this forces a new resource to be created.

 - `vm_size`[*] - (Required) Specifies the size of the Virtual Machine.

 - `network_interface_ids` - (Required) A list of Network Interface ID's which should be associated with the Virtual Machine.

 - `zones` - (Optional) A list of a single item of the Availability Zone which the Virtual Machine should be allocated in. [Default: null]

 - `availability_set_id` - (Optional) The ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created. [Default: null]

 - `proximity_placement_group_id` - (Optional) The ID of the Proximity Placement Group to which this Virtual Machine should be assigned. Changing this forces a new resource to be created. [Default: null]

 - `storage_os_disk` - (Required) An object containing the values for creating an OS disk. Available attributes are caching, create_option, managed_disk_type, os_type and os_disk_size.

 - `storage_data_disk` - (Optional) A list of object containing the values for creating more than one data disks. For each data disk, the available attributes are caching, create_option, disk_size_gb and managed_disk_type. [Default: []]

 - `storage_image_reference` - An object containing values of the image reference. Available attributes are publisher, offer and version.
    
 - `delete_os_disk_on_termination` - (Optional) Should the OS Disk (either the Managed Disk / VHD Blob) be deleted when the Virtual Machine is destroyed? Defaults to false.

 - `delete_data_disks_on_termination` - (Optional) Should the Data Disks (either the Managed Disks / VHD Blobs) be deleted when the Virtual Machine is destroyed? Defaults to false. 

 - `vm_account_credentials` - (Required) An object containing the admin username and password of the virtual machine. Available attributes are admin_username and admin_password.

 - `os_profile_linux_config` - (Required, when a Linux machine) A os_profile_linux_config block.

 - `boot_diagnostics_config` - The configuration values for boot diagnostics. Available attributes are enabled and storage_uri.

 - `tags` - (Required) A mapping of tags to assign to the Virtual Machine.


## Attributes Reference (Outputs)

In addition to all the arguments above, the following attributes are exported:

 - `vm_name` - The Virtual Machine Name.

 - `vm_id` - The Virtual Machine Name ID.

 
## Related STW Modules

`tf-az-vm-availability-set`
`tf-az-vm-ppg`
`tf-az-vm-nic`