# -----------------------------------------------------------------------------------------------------------
# Create A Public IP In Azure With A Public DNS Record
# -----------------------------------------------------------------------------------------------------------

resource "azurerm_public_ip" "public_ip" {
  # name                    = lower(replace(join("-", [var.company_code, var.tags["service"], var.tags["environment"], lookup(var.region_code, var.location), var.publicip_label, "publicip"]), " ", ""))
  name                    = join("-", [var.publicip_label, "publicip"])
  resource_group_name     = lower(var.resource_group_name)
  location                = lower(var.location)
  allocation_method       = var.allocation_method
  sku                     = var.sku
  ip_version              = var.ip_version
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  domain_name_label       = var.domain_name_label
  reverse_fqdn            = lower(var.reverse_fqdn)
  tags                    = var.tags
  # domain_name_label       = join("-", [lower(var.company_code), replace((lower(var.tags["service"])), " ", "-"), replace((lower(var.tags["environment"])), " ", "-"), replace((lower(var.domain_name_label)), " ", "-")])
}
