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

variable "address_prefixes" {
  type        = list(string)
  description = "The list of address prefixes for the subnet"
}
