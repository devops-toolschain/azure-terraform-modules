variable "tags" {
  type        = map(string)
  description = "Tags applied to the resource group."
}

variable "action_group_label" {
  type        = string
  default     = "actiongroup"
  description = "The label abbreviated description used for generating the name. The default setting assumes this is rg. Only to be used if more than 1 resource group is required for the same class of service."
}

#variable for action group
variable "resource_group_name" {
  type        = string
  description = "Azure monitor action group resource group name"
}

variable "azure_monitor_action_group_short_name" {
  type        = string
  description = "short name of the action group"
}


#variable for email Receiver starts
variable "email_receiver_name" {
  type        = string
  description = "email receiver name"
  default     = null
}

variable "email_receiver_email_address" {
 type         = string
 description  = "email receiver address"
 default      = null
}

variable "email_receiver_use_common_alert_schema" {
  type        = bool
  description = "email receiver common alert schema?"
  default     = true
}
#variable for email Receiver ends

variable "location" {
  type        = string
  description = "The Azure region the action group will be created in."
}

variable "company_code" {
  type        = string
  description = "The abbreviated code for the company."
}

variable "region_code" {
  type        = string
  description = "Short code used to identify the Azure region."
}