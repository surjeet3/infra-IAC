environment          = "dev"
resource_group_name  = "rg_surjeet"
vnet_name            = "vnet1"
web_subnet_name      = "web"
webinbound_subnet_name = "webinbound"
# acr_name             = "acr_surjeet"
keyvault_name        = "kv_surjeet"
tenant_id           = "a4375633-7ee4-41b9-8de6-3be5d294de94"  # replace with actual tenant ID
kv_sku_name          = "standard"
apps = {
  app1 = {
    image_name     = "nginx"
    image_tag      = "latest"
    plan_name  = "asp-web-ci-dev-001"   # use existing shared plan
  }
  app2 = {
    image_name     = "wordpress"
    image_tag      = "php8.5-apache"
    plan_name  = null   # will create new dedicated plan
}
 app3 = {
    image_name     = "devopsinsiders/todoapp-ui-new"
    image_tag      = "v2"
    plan_name  = null   # will create new dedicated plan
}
}
