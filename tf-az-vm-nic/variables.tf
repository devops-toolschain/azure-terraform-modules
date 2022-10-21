# -----------------------------------------------------------------------------------------------------------
# Nic Specific Variables
# -----------------------------------------------------------------------------------------------------------

variable "virtual_machine_name" {
  type        = string
  description = "(Required) The name of the virtual machine this NIC will be associated to. Required for the name as the VM doesn't need to exist."
}

variable "nic_number" {
  type        = string
  default     = "0"
  description = "(Required) The number of the network interface. Changing this forces a new resource to be created. The number is used for generating the nic name. Defaults to 0"
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the network interface. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) The location/region where the network interface is created. Changing this forces a new resource to be created."
}

variable "network_security_group_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the Network Security Group to associate with the network interface."
}

variable "internal_dns_name_label" {
  type        = string
  default     = null
  description = "(Optional) Relative DNS name for this NIC used for internal communications between VMs in the same VNet."
}

variable "enable_ip_forwarding" {
  type        = string
  default     = "false"
  description = "(Optional) Enables IP Forwarding on the NIC. Defaults to false."
}

variable "enable_accelerated_networking" {
  type        = string
  default     = "false"
  description = "(Optional) Enables Azure Accelerated Networking using SR-IOV. Only certain VM instance sizes are supported. Refer to Create a Virtual Machine with Accelerated Networking. Defaults to false."
}

variable "dns_servers" {
  type        = list
  default     = null
  description = "(Optional) List of DNS servers IP addresses to use for this NIC, overrides the VNet-level server list."
}

variable "ip_configuration_name" {
  type        = string
  default     = "primaryip"
  description = "(Required) User-defined name of the IP."
}

variable "subnet_id" {
  type        = string
  description = "(Optional) Reference to a subnet in which this NIC has been created. Required when private_ip_address_version is IPv4."
}

variable "private_ip_address" {
  type        = string
  default     = null
  description = "(Optional) Static IP Address."
}

variable "private_ip_address_allocation" {
  type        = string
  default     = "Dynamic"
  description = "(Required) Defines how a private IP address is assigned. Options are Static or Dynamic. Defaults to Dynamic."
}

variable "private_ip_address_version" {
  type        = string
  default     = "IPv4"
  description = "(Optional) The IP Version to use. Possible values are IPv4 or IPv6. Defaults to IPv4."
}

variable "public_ip_address_id" {
  type        = string
  default     = null
  description = "(Optional) Reference to a Public IP Address to associate with this NIC."
}
variable "primary" {
  type        = string
  default     = true
  description = "(Optional) Is this the Primary Network Interface? If set to true this should be the first ip_configuration in the array."
}

variable "secondary_private_ips" {
    type = list(object({
        name_suffix                 = string
        ip_address                  = string
        ip_allocation               = string
        public_ip_address_id        = string
    }))
    default = []
    description = "A list of secondary IP configurations for NIC."
}


variable "tags" {
  type        = map
  description = "Tags applied to the NIC."
}
