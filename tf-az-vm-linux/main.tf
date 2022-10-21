resource "azurerm_virtual_machine" "linux_vm" {
    name                             = local.vm_name
    location                         = var.location
    resource_group_name              = var.resource_group_name
    network_interface_ids            = var.network_interface_ids
    vm_size                          = var.vm_size
    delete_os_disk_on_termination    = var.delete_os_disk_on_termination
    delete_data_disks_on_termination = var.delete_data_disk_on_termination

    zones                            = var.zones
    availability_set_id              = var.availability_set_id
    proximity_placement_group_id     = var.proximity_placement_group_id
    tags                             = var.tags

    storage_os_disk {
      name              = join("-", [local.vm_name, "os-disk"])
      caching           = var.storage_os_disk.caching
      create_option     = var.storage_os_disk.create_option
      managed_disk_type = var.storage_os_disk.managed_disk_type
      disk_size_gb      = var.storage_os_disk.os_disk_size
    }

    dynamic "storage_data_disk" {
        for_each = var.storage_data_disk 
        content {
          name              = join("-", [local.vm_name, "data-disk", storage_data_disk.key + 1])
          lun               = storage_data_disk.key + 1
          caching           = storage_data_disk.value.caching
          create_option     = storage_data_disk.value.create_option
          disk_size_gb      = storage_data_disk.value.disk_size_gb
          managed_disk_type = storage_data_disk.value.managed_disk_type
        }
    }
  
    storage_image_reference {
      publisher = var.storage_image_reference.publisher
      offer     = var.storage_image_reference.offer
      sku       = var.storage_image_reference.sku
      version   = var.storage_image_reference.version
    }

    os_profile {
      computer_name  = local.vm_name
      admin_username = var.vm_account_credentials.admin_username
      admin_password = var.vm_account_credentials.admin_password
    }

    os_profile_linux_config {
      disable_password_authentication = var.disable_password_authentication
    }

    boot_diagnostics {
      enabled     = var.boot_diagnostics_config.enabled
      storage_uri = var.boot_diagnostics_config.storage_uri
    }
}