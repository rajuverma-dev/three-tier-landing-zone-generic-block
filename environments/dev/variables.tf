variable "resource_group" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}

variable "virtual_networks" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    subnets = map(object({
      name             = string
      address_prefixes = list(string)
    }))
  }))
}

variable "network_security_groups" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = optional(map(string))
    security_rules = map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = optional(string)
      destination_port_range     = optional(string)
      source_address_prefix      = optional(string)
      destination_address_prefix = optional(string)
    }))
  }))
}

variable "application_security_groups" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = optional(map(string))
  }))
}

variable "network_interfaces" {
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    subnet_name                   = string
    vnet_name                     = string
    private_ip_address_allocation = string
  }))
}

variable "virtual_machines" {
  type = map(object({
    name                            = string
    resource_group_name             = string
    location                        = string
    size                            = string
    admin_username                  = string
    admin_password                  = string
    disable_password_authentication = bool
    nic_key                         = string

    os_disk = object({
      caching              = string
      storage_account_type = string
    })

    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
}


variable "public_ip" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    tags                = optional(map(string))
  }))
}

variable "storage_account" {
  type = map(object({
    name                     = string
    resource_group_name      = string
    location                 = string
    account_tier             = string
    account_replication_type = string
    tags                     = optional(map(string))
  }))
}



variable "private_endpoints" {
  type = map(object({
    name                 = string
    connection_name      = string
    dns_zone_link_name   = string
    location             = string
    resource_group_name  = string
    subnet_name          = string
    vnet_name            = string
    storage_account_name = string
    private_service_connections = map(object({
      name                 = string
      subresource_names    = list(string)
      is_manual_connection = bool
    }))
    private_dns_zone_groups = map(object({
      name = string
    }))
  }))
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

variable "bastion_host" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
}

variable "key_vault" {
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    enabled_for_disk_encryption = bool
    soft_delete_retention_days  = number
    purge_protection_enabled    = bool
    sku_name                    = string
    access_policies = map(object({

      key_permissions     = list(string)
      secret_permissions  = list(string)
      storage_permissions = list(string)
    }))
  }))

}

variable "mservers" {
  type = map(object({
    name                         = string
    resource_group_name          = string
    location                     = string
    version                      = string
    administrator_login          = string
    administrator_login_password = string
  }))
}

variable "msdatabase" {
  type = map(object({
    name         = string
    collation    = string
    license_type = string
    max_size_gb  = number
    sku_name     = string
    enclave_type = string
    tags         = map(string)
  }))
}

variable "kubernetes_clusters" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = optional(string)
    tags                = optional(map(string))
    nood_pools = map(object({
      name       = string
      node_count = number
      vm_size    = string
    }))

    identities = map(object({
      type = string
    }))
  }))
}

variable "containerregistrys" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    sku                 = string
    admin_enabled       = bool

    georeps = map(object({
      location                = string
      zone_redundancy_enabled = bool
      tags                    = optional(map(string))
    }))
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

