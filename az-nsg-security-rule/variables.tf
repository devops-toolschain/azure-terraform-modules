variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group"
}

variable "network_security_group_name" {
  type        = string
  description = "(Required) The name of the Network Security Group which should be associated with the Subnet."
}

variable "nsg_rules_prefix_range" {
  type          = map(any)
  default       = {}
  description   = "A list of all inbound rules with single range"
}

variable "nsg_rules_prefixes_ranges" {
  type          = map(any)
  default       = {}
  description   = "A list of all inbound rules with multiple ranges"
}