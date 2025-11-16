data "azurerm_public_ip" "pipbdata" {
  for_each            = var.application_gateways
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_subnet" "sbndata" {
  for_each             = var.loadbalancers
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_network_interface" "backnicdata" {
  for_each            = var.loadbalancers
  name                = each.value.backend_nic_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_lb" "lbblock" {
  for_each            = var.loadbalancers
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "frontend_ip_configuration" {
    for_each = each.value.fip_configurations == null ? {} : each.value.fip_configurations
    content {
      name                          = frontend_ip_configuration.value.name
      subnet_id                     = data.azurerm_subnet.sbndata[each.key].id
      private_ip_address_allocation = frontend_ip_configuration.value.private_ip_address_allocation
      private_ip_address            = frontend_ip_configuration.value.private_ip_address
    }
  }
}

resource "azurerm_lb_backend_address_pool" "backendpool" {
  for_each        = var.loadbalancers
  name            = each.value.backend_address_pool_name
  loadbalancer_id = azurerm_lb.lbblock[each.key].id
}

resource "azurerm_lb_probe" "healthprobe" {
  for_each            = var.loadbalancers
  name                = each.value.health_probe_name
  loadbalancer_id     = azurerm_lb.lbblock[each.key].id
  protocol            = each.value.protocol
  port                = each.value.port
  interval_in_seconds = each.value.interval_in_seconds
  number_of_probes    = each.value.number_of_probes
}

resource "azurerm_lb_rule" "lbrule" {
  for_each                       = var.loadbalancers
  name                           = each.value.lb_rule_name
  loadbalancer_id                = azurerm_lb.lbblock[each.key].id
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ipconfig_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backendpool[each.key].id]
  probe_id                       = azurerm_lb_probe.healthprobe[each.key].id
}

resource "azurerm_network_interface_backend_address_pool_association" "nicback" {
  for_each                = var.loadbalancers
  network_interface_id    = data.azurerm_network_interface.backnicdata[each.key].id
  ip_configuration_name   = each.value.nic_ipconfig_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backendpool[each.key].id
}

data "azurerm_subnet" "sbnappgway" {
  for_each             = var.application_gateways
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_application_gateway" "apgblock" {
  for_each            = var.application_gateways
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku {
    name     = each.value.sku.name
    tier     = each.value.sku.tier
    capacity = each.value.sku.capacity
  }

  dynamic "gateway_ip_configuration" {
    for_each = each.value.gateways_ipconfigs == null ? {} : each.value.gateways_ipconfigs
    content {
      name      = gateway_ip_configuration.value.name
      subnet_id = data.azurerm_subnet.sbnappgway[each.key].id
    }
  }

  dynamic "frontend_port" {
    for_each = each.value.gateway_frontports == null ? {} : each.value.gateway_frontports
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = each.value.gateway_frontipconfigs == null ? {} : each.value.gateway_frontipconfigs
    content {
      name                 = frontend_ip_configuration.value.name
      public_ip_address_id = data.azurerm_public_ip.pipbdata[each.key].id
    }

  }

  dynamic "backend_address_pool" {
    for_each = each.value.backend_address_pools == null ? {} : each.value.backend_address_pools
    content {
      name = backend_address_pool.value.name
    }
  }

  dynamic "backend_http_settings" {
    for_each = each.value.backend_http_setts == null ? {} : each.value.backend_http_setts
    content {
      name                  = backend_http_settings.value.name
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      path                  = backend_http_settings.value.path
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      request_timeout       = backend_http_settings.value.request_timeout
    }
  }

  dynamic "http_listener" {
    for_each = each.value.http_listeners == null ? {} : each.value.http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol

    }
  }

  dynamic "request_routing_rule" {
    for_each = each.value.request_routing_rules == null ? {} : each.value.request_routing_rules
    content {
      name                       = request_routing_rule.value.name
      priority                   = request_routing_rule.value.priority
      rule_type                  = request_routing_rule.value.rule_type
      http_listener_name         = request_routing_rule.value.http_listener_name
      backend_address_pool_name  = request_routing_rule.value.backend_address_pool_name
      backend_http_settings_name = request_routing_rule.value.backend_http_setting_name
    }
  }
}

data "azurerm_network_interface" "frontnicdata" {
  for_each            = var.application_gateways
  name                = each.value.frontend_nic_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "poolassblock" {
  for_each                = var.application_gateways
  network_interface_id    = data.azurerm_network_interface.frontnicdata[each.key].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = tolist (azurerm_application_gateway.apgblock[each.key].backend_address_pool)[0].id
}
