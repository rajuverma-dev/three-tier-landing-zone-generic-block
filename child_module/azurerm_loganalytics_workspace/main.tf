data "azurerm_resource_group" "rgdatab" {
  for_each = var.resource_group
  name     = each.value.name
}

variable "log_analytics_workspaces" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    sku                 = string
    retention_in_days   = optional(string)
  }))
}

resource "azurerm_log_analytics_workspace" "logworkblock" {
  for_each            = var.log_analytics_workspaces
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku
  retention_in_days   = each.value.retention_in_days
}
