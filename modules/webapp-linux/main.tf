resource "azurerm_service_plan" "this" {
  name                = "asp-${var.base_name}-001"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
  tags                = var.tags
}
resource "azurerm_service_plan" "dedicated" {
  for_each = { for k, v in var.apps : k => v if v.plan_name == null }
  name                = "asp-${var.base_name}-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "B1"
  tags                = var.tags
}
resource "azurerm_linux_web_app" "this" {
  for_each            = var.apps
  name                = "app-${var.base_name}-${each.key}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = (
    each.value.plan_name != null 
    ? azurerm_service_plan.this.id 
    : azurerm_service_plan.dedicated[each.key].id
  )
  identity {
    type = "SystemAssigned"
  }

  site_config {
    application_stack {
      docker_image_name = "${each.value.image_name}:${each.value.image_tag}"
    }
    container_registry_use_managed_identity = true
    vnet_route_all_enabled                  = true
    always_on                               = false
  }

  virtual_network_subnet_id = var.subnet_id_web

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    DOCKER_REGISTRY_SERVER_URL          = "https://index.docker.io"
    # DB_PASSWORD = "@Microsoft.KeyVault(SecretUri=${each.value.db_secret_uri})"
    # API_KEY     = "@Microsoft.KeyVault(SecretUri=${each.value.api_secret_uri})"
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "this" {
  for_each            = azurerm_linux_web_app.this
  name                = "pep-${each.key}-${var.base_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id          = var.subnet_id_webinbound

  private_service_connection {
    name                           = "psc-${each.key}"
    private_connection_resource_id = each.value.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}

# resource "azurerm_role_assignment" "acr" {
#   for_each             = azurerm_linux_web_app.this
#   scope                = var.acr_id
#   role_definition_name = "AcrPull"
#   principal_id         = each.value.identity[0].principal_id
# }

# resource "azurerm_role_assignment" "kv" {
#   for_each             = azurerm_linux_web_app.this
#   scope                = var.keyvault_id
#   role_definition_name = "Key Vault Secrets User"
#   principal_id         = each.value.identity[0].principal_id
# }
