# -----------------------------------------------------------------------------------------------------------
# Log Analytics Variables
# -----------------------------------------------------------------------------------------------------------


variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which the Log Analytics workspace is created. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "sku" {
  type        = string
  default     = "PerGB2018"
  description = "(Required) Specifies the Sku of the Log Analytics Workspace. Possible values are Free, PerNode, Premium, Standard, Standalone, Unlimited, and PerGB2018 (new Sku as of 03-04-2018." # NOTE: A new pricing model took effect on 03-04-2018, which requires the SKU PerGB2018. If you're provisioned resources before this date you have the option of remaining with the previous Pricing SKU and using the other SKU's defined.
}

variable "retention_in_days" {
  type        = string
  default     = "30"
  description = "(Optional) The workspace data retention in days. Possible values range between 30 and 730."
}

variable "tags" {
  type        = map
  description = "Tags applied to the Log Analytics Workspace."
}

variable "company_code" {
  type        = string
  default     = "st"
  description = "The abreviated code for the company."
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

variable "retention" {
  type        = string
  default     = "30"
  description = "Retention range 30 - 730."
}