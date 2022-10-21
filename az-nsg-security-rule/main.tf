# Security Rules for single prefix and range
resource "azurerm_network_security_rule" "nsg_rules_prefix_range" {
  for_each = var.nsg_rules_prefix_range
    name                          = each.value["name"]
    priority                      = each.value["priority"]
    direction                     = each.value["direction"]
    access                        = each.value["access"]
    protocol                      = each.value["protocol"]
    source_address_prefix         = each.value["source_address_prefix"]
    source_port_range             = each.value["source_port_range"]
    destination_address_prefix    = each.value["destination_address_prefix"]
    destination_port_range        = each.value["destination_port_range"]
    resource_group_name           = lower(var.resource_group_name)
    network_security_group_name   = var.network_security_group_name
    description                   = each.value["description"]
}

# Security Rules for multiple prefixes and ranges
resource "azurerm_network_security_rule" "nsg_rules_prefixes_ranges" {
  for_each = var.nsg_rules_prefixes_ranges
    name                          = each.value["name"]
    priority                      = each.value["priority"]
    direction                     = each.value["direction"]
    access                        = each.value["access"]
    protocol                      = each.value["protocol"]
    source_address_prefixes       = each.value["source_address_prefixes"]
    source_port_range             = each.value["source_port_range"]
    destination_address_prefix    = each.value["destination_address_prefix"]
    destination_port_ranges       = each.value["destination_port_ranges"]
    resource_group_name           = lower(var.resource_group_name)
    network_security_group_name   = var.network_security_group_name
    description                   = each.value["description"]
}