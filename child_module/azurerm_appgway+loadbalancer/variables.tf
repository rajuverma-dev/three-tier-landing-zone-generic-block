variable "public_ip" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    tags                = optional(map(string))
  }))
}

variable "loadbalancers" {
  type = map(object({
    name                      = string
    location                  = string
    resource_group_name       = string
    subnet_name               = string
    vnet_name                 = string
    backend_address_pool_name = string
    health_probe_name         = string
    protocol                  = string
    port                      = number
    interval_in_seconds       = number
    number_of_probes          = number
    lb_rule_name              = string
    frontend_port             = number
    backend_port              = number
    frontend_ipconfig_name    = string
    backend_nic_name          = string
    nic_ipconfig_name         = string
    fip_configurations = map(object({
      name                          = string
      private_ip_address_allocation = string
      private_ip_address            = string
    }))
  }))
}

variable "application_gateways" {
  type = map(object({
    name                      = string
    resource_group_name       = string
    location                  = string
    public_ip_name            = string
    subnet_name               = string
    vnet_name                 = string
    frontend_nic_name         = string
    backend_address_pool_name = string
    sku = object({
      name     = string
      tier     = string
      capacity = number
    })
    gateways_ipconfigs = map(object({
      name        = string
      subnet_name = string
      vnet_name   = string
    }))
    gateway_frontports = map(object({
      name = string
      port = number
    }))
    gateway_frontipconfigs = map(object({
      name = string
    }))
    backend_address_pools = map(object({
      name = string
    }))
    backend_http_setts = map(object({
      name                  = string
      cookie_based_affinity = string
      path                  = string
      port                  = number
      protocol              = string
      request_timeout       = number
    }))
    http_listeners = map(object({
      name                           = string
      frontend_ip_configuration_name = string
      frontend_port_name             = string
      protocol                       = string
    }))
    request_routing_rules = map(object({
      name                      = string
      priority                  = number
      rule_type                 = string
      http_listener_name        = string
      backend_address_pool_name = string
      backend_http_setting_name = string
    }))
  }))
}
