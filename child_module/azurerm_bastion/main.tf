data "azurerm_subnet" "sbnbdata" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = "dev-vnet-52117"
  resource_group_name  = "dev_rg_251025"
}

data "azurerm_public_ip" "pipbdata" {
  name                = "dev_public_ip_bastn"
  resource_group_name = "dev_rg_251025"
}

resource "azurerm_bastion_host" "bhostblock" {
  for_each            = var.bastion_host
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.sbnbdata.id
    public_ip_address_id = data.azurerm_public_ip.pipbdata.id
  }
}
