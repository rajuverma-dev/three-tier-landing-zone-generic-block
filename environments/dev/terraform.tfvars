resource_group = {
  rg1 = {
    name       = "dev_rg_251025"
    location   = "centralindia"
    managed_by = "dev"
    tags = {
      owner = "Devopians"
      cost  = "7$"
    }
  }
}

public_ip = {
  pip1 = {
    name                = "dev_public_ip_bastn"
    resource_group_name = "dev_rg_251025"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      managed_by = "Devopians"
    }
  }

  pip2 = {
    name                = "dev_public_ip_lb"
    resource_group_name = "dev_rg_251025"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      managed_by = "Devopians"
    }
  }
}

virtual_networks = {
  vnet1 = {
    name                = "dev-vnet-52117"
    address_space       = ["10.0.0.0/16"]
    location            = "centralindia"
    resource_group_name = "dev_rg_251025"
    subnets = {
      subnet1 = {
        name             = "frontend_subnet"
        address_prefixes = ["10.0.1.0/24"]
      }
      subnet2 = {
        name             = "backend_subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
      subnet3 = {
        name             = "AzureBastionSubnet"
        address_prefixes = ["10.0.3.0/24"]

      }
      subnet4 = {
        name             = "Application_gatewaySubnet"
        address_prefixes = ["10.0.4.0/24"]

      }
      subnet5 = {
        name             = "private-endpoint-subnet"
        address_prefixes = ["10.0.5.0/24"]

      }
    }
  }
}

network_security_groups = {
  nsg1 = {
    name                = "dev-network-sec-group-251109"
    location            = "centralindia"
    resource_group_name = "dev_rg_251025"
    tags = {
      owner = "Devopians"
    }
    security_rules = {
      security_rule1 = {
        name                       = "dev-ruleset-251109"
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
}

application_security_groups = {
  "appsg1" = {
    name                = "dev-app-sec-group-251109"
    location            = "centralindia"
    resource_group_name = "dev_rg_251025"
    tags = {
      owner = "Devopians"
    }
  }
}

network_interfaces = {
  nic1 = {
    name                          = "dev-frontend-nic-251011"
    location                      = "centralindia"
    resource_group_name           = "dev_rg_251025"
    subnet_name                   = "frontend_subnet"
    vnet_name                     = "dev-vnet-52117"
    private_ip_address_allocation = "Dynamic"
  }

  nic2 = {
    name                          = "dev-backend-nic-251011"
    location                      = "centralindia"
    resource_group_name           = "dev_rg_251025"
    subnet_name                   = "backend_subnet"
    vnet_name                     = "dev-vnet-52117"
    private_ip_address_allocation = "Dynamic"
  }
}

virtual_machines = {
  vm1 = {
    name                            = "dev-vm-frontend"
    resource_group_name             = "dev_rg_251025"
    location                        = "centralindia"
    size                            = "Standard_B1s"
    admin_username                  = "devadmineuser"
    admin_password                  = "devadmin@1928"
    disable_password_authentication = false
    nic_key                         = "nic1"


    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"
    }
  }

  vm2 = {
    name                            = "dev-vm-backend"
    resource_group_name             = "dev_rg_251025"
    location                        = "centralindia"
    size                            = "Standard_B1s"
    admin_username                  = "devadmineuser"
    admin_password                  = "devadmin@1928"
    disable_password_authentication = false
    nic_key                         = "nic2"

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"
    }
  }
}

storage_account = {
  storage1 = {
    name                     = "devstorage251211"
    resource_group_name      = "dev_rg_251025"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    tags = {
      managed_by = "dev"
    }
  }
}

private_endpoints = {
  penpoint1 = {
    name                 = "dev-pri-endpoint_251011"
    connection_name      = "dev-connect"
    dns_zone_link_name   = "privatelink.blob.core.windows.net"
    location             = "centralindia"
    resource_group_name  = "dev_rg_251025"
    subnet_name          = "private-endpoint-subnet"
    vnet_name            = "dev-vnet-52117"
    storage_account_name = "devstorage251211"

    private_service_connections = {
      prisercon1 = {
        name                 = "dev-privateserviceconnection"
        subresource_names    = ["blob"]
        is_manual_connection = false
      }
    }

    private_dns_zone_groups = {
      pri_dns_zone1 = {
        name = "dev-pri-dns-zone-251011"
      }
    }
  }
}

log_analytics_workspaces = {
  log_workspace1 = {
    name                = "dev-loganlytic-workspace-251011"
    location            = "centralindia"
    resource_group_name = "dev_rg_251025"
    sku                 = "PerGB2018"

  }
}

bastion_host = {
  bh1 = {
    name                = "dev_bastion_021125"
    location            = "centralindia"
    resource_group_name = "dev_rg_251025"
    ip_configuration = {
      name        = "configuration"
      subnet_name = "AzureBastionSubnet"
    }
  }
}

key_vault = {
  kv1 = {
    name                        = "dev-keyvault251211"
    location                    = "centralindia"
    resource_group_name         = "dev_rg_251025"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
    access_policies = {
      ap1 = {
        key_permissions     = ["Get", "List"]
        secret_permissions  = ["Get", "List"]
        storage_permissions = ["Get", "List"]
      }

    }
  }
}

mservers = {
  mserver1 = {
    name                         = "dev-sqlserver-051125"
    resource_group_name          = "dev_rg_251025"
    location                     = "centralindia"
    version                      = "12.0"
    administrator_login          = "adminuser051125"
    administrator_login_password = "devuser@7182"
  }
}

msdatabase = {
  mdb1 = {
    name         = "dev-sqldb-051125"
    collation    = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    max_size_gb  = 2
    sku_name     = "S0"
    enclave_type = "VBS"
    tags = {
      tag1 = "foo"
    }
  }
}

kubernetes_clusters = {
  aks1 = {
    name                = "dev-kubernetes-cluster-251011"
    location            = "centralindia"
    resource_group_name = "dev_rg_251025"
    dns_prefix          = "dev-aks-dns-prefix"
    tags = {
      owner = "Devopians"
    }

    nood_pools = {
      pool1 = {
        name       = "default"
        node_count = 1
        vm_size    = "Standard_B2s"
      }
    }

    identities = {
      identity1 = {
        type = "SystemAssigned"
      }
    }
  }
}

containerregistrys = {
  registry1 = {
    name                = "devcontainerRegistry251011"
    resource_group_name = "dev_rg_251025"
    location            = " centralindia"
    sku                 = "Premium"
    admin_enabled       = false

    georeps = {
      georep1 = {
        location                = "East US"
        zone_redundancy_enabled = true
        tags = {
          owner = "Devopians"
        }
      }
    }

    georep2 = {
      location                = "centralindia"
      zone_redundancy_enabled = true
      tags = {
        owner = "Devopians"
      }
    }
  }
}

loadbalancers = {
  lb1 = {
    name                      = "dev-internal-loadbalancer"
    location                  = "centralindia"
    resource_group_name       = "dev_rg_251025"
    subnet_name               = "backend_subnet"
    vnet_name                 = "dev-vnet-52117"
    backend_address_pool_name = "ilb-backend-address-pool"
    health_probe_name         = "ilb-health-probe"
    protocol                  = "Tcp"
    port                      = 8080
    interval_in_seconds       = 5
    number_of_probes          = 2
    lb_rule_name              = "ilb-backend-rule"
    frontend_port             = 8080
    backend_port              = 8080
    frontend_ipconfig_name    = "ilb-PrivateIPAddress"
    backend_nic_name          = "dev-backend-nic-251011"
    nic_ipconfig_name         = "internal"

    fip_configurations = {
      fip1 = {
        name                          = "ilb-PrivateIPAddress"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.0.2.7"
      }
    }
  }
}

application_gateways = {
  apg1 = {
    name                      = "dev-appgateway"
    resource_group_name       = "dev_rg_251025"
    location                  = "centralindia"
    public_ip_name            = "dev_public_ip_lb"
    subnet_name               = "Application_gatewaySubnet"
    vnet_name                 = "dev-vnet-52117"
    frontend_nic_name         = "dev-frontend-nic-251011"
    backend_address_pool_name = "dev-backend-address-pool"
    sku = {
      name     = "Standard_v2"
      tier     = "Standard_v2"
      capacity = 2
    }

    gateways_ipconfigs = {
      gatwayconfig1 = {
        name        = "dev-gateway-ip-configuration"
        subnet_name = "Application_gatewaySubnet"
        vnet_name   = "dev-vnet-52117"
      }
    }
    gateway_frontports = {
      frontport1 = {
        name = "dev-frontend-port"
        port = 80
      }
    }
    gateway_frontipconfigs = {
      ipconfig1 = {
        name = "dev-frontend-ip-configuration"
      }
    }
    backend_address_pools = {
      backend_addpool = {
        name = "dev-backend-address-pool"
      }
    }
    backend_http_setts = {
      back_http_sett1 = {
        name                  = "dev-http-setting"
        cookie_based_affinity = "Disabled"
        path                  = "/path1/"
        port                  = 80
        protocol              = "Http"
        request_timeout       = 60
      }
    }
    http_listeners = {
      listener1 = {
        name                           = "dev-listener"
        frontend_ip_configuration_name = "dev-frontend-ip-configuration"
        frontend_port_name             = "dev-frontend-port"
        protocol                       = "Http"
      }
    }
    request_routing_rules = {
      routing_rule1 = {
        name                      = "dev-request-routing-rule"
        priority                  = 9
        rule_type                 = "Basic"
        http_listener_name        = "dev-listener"
        backend_address_pool_name = "dev-backend-address-pool"
        backend_http_setting_name = "dev-http-setting"
      }
    }
  }
}


