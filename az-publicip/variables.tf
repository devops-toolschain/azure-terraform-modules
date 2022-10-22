# -----------------------------------------------------------------------------------------------------------
# Public IP Specific Variables
# -----------------------------------------------------------------------------------------------------------

variable "publicip_label" {
  type        = string
  description = "(Required) The text string used to identify what resource the public IP is associated with and is used to dynamically build the public ip name."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the public ip."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "allocation_method" {
  type        = string
  default     = "Dynamic"
  description = "(Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic. The default is Dynamic"
}

variable "sku" {
  type        = string
  default     = "Basic"
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
}

variable "ip_version" {
  type        = string
  default     = "IPv4"
  description = "(Optional) The IP Version to use, IPv6 or IPv4. The default is IPv4."
}

variable "idle_timeout_in_minutes" {
  type        = string
  default     = "4"
  description = "(Optional) Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes. The default is 4."
}

variable "domain_name_label" {
  type        = string
  default     = null
  description = "(Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
}

variable "reverse_fqdn" {
  type        = string
  default     = null
  description = "(Optional) A fully qualified domain name that resolves to this public IP address. If the reverseFqdn is specified, then a PTR DNS record is created pointing from the IP address in the in-addr.arpa domain to the reverse FQDN."
}

variable "company_code" {
  type        = string
  default     = "st"
  description = "The abbreviated code for the company."
}

variable "tags" {
  type        = map
  description = "Tags applied to the public IP."
}

variable "region_code" {
  type        = map
  description = "Short code used to identify the Azure region."
  default = {
    "northeurope" = "neu"
    "westeurope"  = "weu"
    "uksouth"     = "uks"
    "ukwest"      = "ukw"
  }
}
