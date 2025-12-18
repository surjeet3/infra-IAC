terraform {
  backend "azurerm" {
    resource_group_name  = "rg_surjeet"
    storage_account_name = "stgsurjeet"
    container_name       = "tfstate"
    key                  = "dev.tfstate"
  }
}

#------------------
# use below when- Backend values will be injected from GitHub Actions, not hardcoded
#------------------
# terraform {
#   backend "azurerm" {}
# }
