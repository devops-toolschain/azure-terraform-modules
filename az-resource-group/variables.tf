variable "name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location/region where the resource group must be created"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "The tags for the resource group"
}
