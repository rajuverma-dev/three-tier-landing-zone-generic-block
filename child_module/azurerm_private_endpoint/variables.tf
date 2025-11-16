variable "private_endpoints" {
  type = map(object({
    name                 = string
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



