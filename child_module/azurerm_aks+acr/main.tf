data "azurerm_resource_group" "rgdatab" {
  for_each = var.resource_group
  name     = each.value.name
}

resource "azurerm_kubernetes_cluster" "aksblock" {
  for_each            = var.kubernetes_clusters
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix
  tags                = each.value.tags

  dynamic "default_node_pool" {
    for_each = each.value.nood_pools == null ? {} : each.value.nood_pools
    content {
      name       = default_node_pool.value.name
      node_count = default_node_pool.value.node_count
      vm_size    = default_node_pool.value.vm_size
    }
  }

  dynamic "identity" {
    for_each = each.value.identities == null ? {} : each.value.identities
    content {
      type = identity.value.type
    }
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_container_registry" "acrblock" {
  for_each            = var.containerregistrys
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku
  admin_enabled       = each.value.admin_enabled

  dynamic "georeplications" {
    for_each = each.value.georeps == null ? {} : each.value.georeps
    content {
      location                = georeplications.value.location
      zone_redundancy_enabled = georeplications.value.zone_redundancy_enabled
      tags                    = georeplications.value.tags
    }
  }
}
