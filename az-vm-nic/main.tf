# -----------------------------------------------------------------------------------------------------------
# Create A Nic In Azure
# -----------------------------------------------------------------------------------------------------------

resource "azurerm_network_interface" "vm_nic" {
  name                          = replace(join("-", [lower(var.virtual_machine_name), "eth", var.nic_number, "nic"]), "eth-", "eth")
  resource_group_name           = lower(var.resource_group_name)
  location                      = lower(var.location)
  internal_dns_name_label       = var.internal_dns_name_label
  enable_ip_forwarding          = var.enable_ip_forwarding
  enable_accelerated_networking = var.enable_accelerated_networking
  dns_servers                   = var.dns_servers

  # Primary IP Configuration
  ip_configuration {
    name                          = lower(var.ip_configuration_name)
    subnet_id                     = var.subnet_id
    private_ip_address            = var.private_ip_address
    private_ip_address_allocation = var.private_ip_address_allocation
    private_ip_address_version    = var.private_ip_address_version
    public_ip_address_id          = var.public_ip_address_id
    primary                       = var.primary
  }

  # Secondary IP Configuration to add multiple secondary IPs
  dynamic "ip_configuration" {
    for_each = var.secondary_private_ips
    content {
      name                          = lower(join("-", [var.virtual_machine_name, join("", ["eth", var.nic_number]), ip_configuration.value.name_suffix]))
      subnet_id                     = var.subnet_id
      private_ip_address            = ip_configuration.value.ip_address
      private_ip_address_allocation = ip_configuration.value.ip_allocation
      private_ip_address_version    = var.private_ip_address_version
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
      primary                       = false
    }
  }
  tags = var.tags
}

resource azurerm_network_interface_security_group_association "nsg_association" {
  # This resource is AzureRM provider v2.x specific....
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = var.network_security_group_id
}