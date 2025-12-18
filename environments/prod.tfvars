environment = "prod"

resource_group_name = "rg_surjeet_prod"
vnet_name           = "vnet1"
web_subnet_name     = "web_prod"
acr_name            = "acr_surjeet_prod"
keyvault_name       = "kv_surjeet_prod"

db_secret_uri  = "https://kv_surjeet_prod.vault.azure.net/secrets/db-password"
api_secret_uri = "https://kv_surjeet_prod.vault.azure.net/secrets/api-key"
