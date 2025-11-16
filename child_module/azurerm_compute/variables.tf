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
