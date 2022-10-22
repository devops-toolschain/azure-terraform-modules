locals {
  vm_name = lower(replace(var.vm_name, " ", ""))
  # ssh_key_path = "/home/${local.vm_name}/.ssh/authorized_keys"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the resource"
}

variable "vm_name" {
  type        = string
  description = "The name of the virtual machine"
}

variable "vm_size" {
  type        = string
  description = "The size of the VM"
}

# variable "delete_os_disk_on_termination" {
#   type    = bool
#   default = "true"
# }
#
# variable "delete_data_disk_on_termination" {
#   type    = bool
#   default = "true"
# }

variable "network_interface_ids" {
  type        = list(string)
  description = "(Required) A list of Network Interface ID's which should be associated with the Virtual Machine"
}

variable "zones" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of a single item of the Availability Zone which the Virtual Machine should be allocated in."
}

variable "availability_set_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created."
}

variable "proximity_placement_group_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the Proximity Placement Group to which this Virtual Machine should be assigned. Changing this forces a new resource to be created."
}

# variable "enable_accelerated_networking" {
#   type        = bool
#   default     = false
#   description = "(Optional) Enables Azure Accelerated Networking using SR-IOV. Only certain VM instance sizes are supported. Refer to Create a Virtual Machine with Accelerated Networking. Defaults to false."
# }

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    disk_size_gb         = string
  })
  description = "The os_disk settings"
}

# variable "storage_data_disk" {
#   type = list(object({
#     caching           = string
#     create_option     = string
#     disk_size_gb      = string
#     managed_disk_type = string
#   }))
#   default     = []
#   description = "The storage_data_disk_config settings for each environment"
# }

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "The source_image_reference settings"
}

variable "admin_username" {
  type        = string
  description = "Admin username"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key"
}

# variable "disable_password_authentication" {
#   type    = bool
#   default = "false"
# }
#
# variable "boot_diagnostics_config" {
#   type = object({
#     enabled     = bool
#     storage_uri = string
#   })
#   description = "The boot_diagnostics settings"
# }

variable "tags" {
  type        = map(string)
  description = "The tags assigned to the resource"
}
