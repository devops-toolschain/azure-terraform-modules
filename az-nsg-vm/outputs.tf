# -----------------------------------------------------------------------------------------------------------
# tf-az-nsg Module Outputs
# -----------------------------------------------------------------------------------------------------------

output "id" {
  description = "The Network Security Group ID."
  value       = azurerm_network_security_group.nsg_vm.id
}

output "name" {
  description = "The Network Security Group name."
  value       = azurerm_network_security_group.nsg_vm.name
}
