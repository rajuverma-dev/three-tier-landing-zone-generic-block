module "resource_group" {
  source = "../../child_module/azurerm_resource_group"
  rgs    = var.resource_group
}

module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../child_module/azurerm_public_ip"
  public_ip  = var.public_ip
}

module "network" {
  depends_on       = [module.resource_group]
  source           = "../../child_module/azurerm_networking"
  virtual_networks = var.virtual_networks

}

module "compute" {
  depends_on                  = [module.network]
  source                      = "../../child_module/azurerm_compute"
  network_interfaces          = var.network_interfaces
  virtual_machines            = var.virtual_machines
  virtual_networks            = var.virtual_networks
  network_security_groups     = var.network_security_groups
  application_security_groups = var.application_security_groups
}

module "bastion" {
  depends_on   = [module.network, module.public_ip]
  source       = "../../child_module/azurerm_bastion"
  bastion_host = var.bastion_host
}

module "storage_account" {
  depends_on      = [module.resource_group]
  source          = "../../child_module/azurerm_storage_account"
  storage_account = var.storage_account
}

module "private_endpoints" {
  depends_on        = [module.network, module.storage_account]
  source            = "../../child_module/azurerm_private_endpoint"
  private_endpoints = var.private_endpoints
}

module "log_analytics_workspaces" {
  depends_on               = [module.resource_group]
  source                   = "../../child_module/azurerm_loganalytics_workspace"
  log_analytics_workspaces = var.log_analytics_workspaces
  resource_group           = var.resource_group
}

module "key_vault" {
  depends_on = [module.resource_group]
  source     = "../../child_module/azurerm_key_vault"
  key_vault  = var.key_vault
}

module "mserver" {
  depends_on = [module.resource_group]
  source     = "../../child_module/azurerm_mssql_server"
  mservers   = var.mservers
}

module "msdatabase" {
  depends_on = [module.mserver]
  source     = "../../child_module/azurerm_mssql_db"
  msdatabase = var.msdatabase
}

module "kubernetes_clusters" {
  depends_on          = [module.resource_group]
  source              = "../../child_module/azurerm_aks+acr"
  kubernetes_clusters = var.kubernetes_clusters
  resource_group      = var.resource_group
  containerregistrys  = var.containerregistrys
}

module "loadbalancer" {
  depends_on           = [module.public_ip, module.compute]
  source               = "../../child_module/azurerm_appgway+loadbalancer"
  loadbalancers        = var.loadbalancers
  public_ip            = var.public_ip
  application_gateways = var.application_gateways
}
