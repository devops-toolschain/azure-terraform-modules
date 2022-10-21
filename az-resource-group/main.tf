resource "azurerm_resource_group" "resource_group" {
  name      = join("-", [var.name, "rg"])
  location  = var.location
  tags      = var.tags
}