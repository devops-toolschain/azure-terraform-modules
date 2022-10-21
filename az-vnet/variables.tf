variable "name" {
  type        = string
  description = "The name of the vnet"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resopurce group for the vnet"
}

variable "location" {
  type        = string
  description = "The location/region where the vnet must be created"
}

variable "address_space" {
  type        = list(string)
  description = "A list address space for the vnet"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "The tags for the vnet"
}
