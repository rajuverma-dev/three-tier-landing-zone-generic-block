variable "resource_group" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
  }))
}


variable "kubernetes_clusters" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = optional(string)
    tags                = map(string)
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
