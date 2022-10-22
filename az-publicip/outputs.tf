# -----------------------------------------------------------------------------------------------------------
# tf-az-publicip Module Outputs
# -----------------------------------------------------------------------------------------------------------

output "id" {
  description = "The Public IP ID"
  value       = azurerm_public_ip.public_ip.id
}

output "name" {
  description = "The name of the Public IP created"
  value       = azurerm_public_ip.public_ip.name
}

output "ip_address" {
  description = "The IP address value that was allocated."
  value       = azurerm_public_ip.public_ip.ip_address
}
