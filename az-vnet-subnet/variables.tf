variable "name" {
  type        = string
  description = "The name of the vnet"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resopurce group for the vnet"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "address_prefix" {
  type        = string
  description = "The address prefix for the subnet"
}