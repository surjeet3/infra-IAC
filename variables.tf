variable "environment" {}
variable "location" {
  default = "centralindia"
}
variable.tenant_id {}
variable "resource_group_name" {}
variable "vnet_name" {}
variable "web_subnet_name" {}
variable "webinbound_subnet_name" {}
# variable "acr_name" {}
variable "keyvault_name" {}
variable "kv_sku_name" {
  description = "The SKU name of the Key Vault. Possible values are 'standard' and 'premium'."
  type        = string
  default     = "standard"
}

variable "apps" {
  description = "Map of web apps"
  type = map(object({
    image_name     = string
    image_tag      = string
    plan_name  = optional(string)
    # db_secret_uri  = string
    # api_secret_uri = string
  }))
}
variable "keyvault_secrets" {
  description = "Key Vault secrets"
  type        = map(string)
}
variable "db_password" {
  description = "Database password to be stored in Key Vault"
  type        = string
}
variable "api_key" {
  description = "API key to be stored in Key Vault"
  type        = string
}