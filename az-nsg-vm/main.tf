# -----------------------------------------------------------------------------------------------------------
# Create A Network Security Group For A Virtual Machine NIC In Azure
# -----------------------------------------------------------------------------------------------------------

resource "azurerm_network_security_group" "nsg_vm" {
  name                = lower(join("-", [var.virtual_machine_name, "nsg"]))
  resource_group_name = lower(var.resource_group_name)
  location            = lower(var.location)
  tags                = var.tags
}
