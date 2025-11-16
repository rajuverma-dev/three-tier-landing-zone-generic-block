data "azurerm_storage_account" "stgdata" {
  for_each            = var.private_endpoints
  name                = each.value.storage_account_name
  resource_group_name = each.value.resource_group_name

}

data "azurerm_subnet" "priensbndata" {
  for_each             = var.private_endpoints
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name

}

resource "azurerm_private_dns_zone" "pridnslink" {
  for_each            = var.private_endpoints
  name                = each.value.dns_zone_link_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_private_endpoint" "prienblock" {
  for_each            = var.private_endpoints
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = data.azurerm_subnet.priensbndata[each.key].id

  dynamic "private_service_connection" {
    for_each = each.value.private_service_connections == null ? {} : each.value.private_service_connections
    content {
      name                           = private_service_connection.value.name
      private_connection_resource_id = data.azurerm_storage_account.stgdata[each.key].id
      subresource_names              = private_service_connection.value.subresource_names
      is_manual_connection           = private_service_connection.value.is_manual_connection
    }
  }

  dynamic "private_dns_zone_group" {
    for_each = each.value.private_dns_zone_groups == null ? {} : each.value.private_dns_zone_groups
    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = [azurerm_private_dns_zone.pridnslink[each.key].id]
    }
  }
}
