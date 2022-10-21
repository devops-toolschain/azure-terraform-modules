# -----------------------------------------------------------------------------------------------------------
# tf-az-nic-dynamic Module Outputs
# -----------------------------------------------------------------------------------------------------------

output "id" {
  description = "The Virtual Network Interface ID."
  value       = azurerm_network_interface.vm_nic.id
}

output "mac_address" {
  description = "The media access control (MAC) address of the network interface."
  value       = azurerm_network_interface.vm_nic.mac_address
}

output "private_ip_address" {
  description = "The first private IP address of the network interface."
  value       = azurerm_network_interface.vm_nic.private_ip_address
}

output "ipconfig" {
  description = "The first private IP address of the network interface."
  value       = azurerm_network_interface.vm_nic.ip_configuration[0].name
}
