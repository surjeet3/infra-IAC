data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_subnet" "web" {
  name                 = var.web_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}
data "azurerm_subnet" "webinbound" {
  name                 = var.webinbound_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

# data "azurerm_container_registry" "acr" {
#   name                = var.acr_name
#   resource_group_name = var.resource_group_name
# }

# data "azurerm_key_vault" "kv" {
#   name                = var.keyvault_name
#   resource_group_name = var.resource_group_name
# }

# module "webapp_stack" {
#   source = "./modules/webapp-linux"

#   resource_group_name = var.resource_group_name
#   location            = var.location
#   environment         = var.environment
#   subnet_id_web           = data.azurerm_subnet.web.id
#   subnet_id_webinbound = data.azurerm_subnet.webinbound.id
# #   acr_id              = data.azurerm_container_registry.acr.id
# #   keyvault_id         = data.azurerm_key_vault.kv.id
#   base_name           = local.base_name
#   tags                = local.tags

#   apps = var.apps
# }
# data "azurerm_client_config" "current" {}
# resource "random_string" "random_name" {
#   length  = 8
#   special = false
#   upper   = false
# }
# module "keyvault" {
#   source  = "Azure/avm-res-keyvault-vault/azurerm"
#   version = "~> 0.6"

#   name                = "kv-ci-dev-${random_string.random_name.result}"
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   tenant_id           = data.azurerm_client_config.current.tenant_id

#   sku_name = "standard"
#   # soft_delete_retention_days = 90
#   purge_protection_enabled  = false
#   network_acls = null
# }
# resource "azurerm_role_assignment" "kv_admin" {
#   scope                = module.keyvault.resource_id
#   role_definition_name = "Key Vault Administrator"
#   principal_id         = data.azurerm_client_config.current.object_id
# }
# module "avm-res-keyvault-vault_secret" {
#   source  = "Azure/avm-res-keyvault-vault/azurerm//modules/secret"
#   version = "0.10.2"

#   for_each = var.keyvault_secrets

#   name                   = each.key
#   value                  = each.value
#   key_vault_resource_id = module.keyvault.resource_id
#   depends_on = [azurerm_role_assignment.kv_admin]
# }
module "keyvault" {
  source = "./modules/kv"

  keyvault_name        = var
  location             = var.location
  resource_group_name  = var.resource_group_name
  tenant_id            = var.tenant_id
  sku_name             = var.sku_name

  secrets = {
    "DbPassword" = var.db_password
    "ApiKey"     = var.api_key
  }
}