resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  #original name                = "${lower(var.company_code)}-${replace(lower(var.tags["service"]), " ", "-")}-${replace(lower(var.tags["environment"]), " ", "-")}-${lookup(var.region_code, var.location)}-logaw"
  #works name                = join("-", [lower(var.company_code), replace((lower(var.tags["service"])), " ", "-"), replace((lower(var.tags["environment"])), " ", "-"), lookup(var.region_code, var.location), "logaw"])
  #works-move lower outside name                = lower(join("-", [var.company_code, replace(var.tags["service"], " ", "-"), replace(var.tags["environment"], " ", "-"), lookup(var.region_code, var.location), "logaw"]))
  name                = lower(replace(join("-", [var.company_code, var.tags["service"], var.tags["environment"], lookup(var.region_code, var.location), "logaw"]), " ", ""))
  resource_group_name = lower(var.resource_group_name)
  location            = lower(var.location)
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}