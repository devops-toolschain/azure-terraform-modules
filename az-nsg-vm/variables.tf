# -----------------------------------------------------------------------------------------------------------
# nsg Specific Variables
# -----------------------------------------------------------------------------------------------------------

variable "virtual_machine_name" {
  type        = string
  description = "(Required) The name of the virtual machine this NIC will be associated to."
}

variable "resource_group_name" {
  type        = string
  description = "The resource group the nsg will be created in."
}

variable "location" {
  type        = string
  description = "The Azure region the nsg will be created in."
}

variable "tags" {
  type        = map
  description = "Tags applied to the NSG."
}
