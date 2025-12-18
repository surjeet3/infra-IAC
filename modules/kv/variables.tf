variable "tenant_id" {}
variable "keyvault_name" {}
variable "keyvault_secrets" {
  description = "Key Vault secrets"
  type        = map(string)
}
variable "location" {
  default = "centralindia"
}
variable "resource_group_name" {}
variable "kv_sku_name" {
  description = "The SKU name of the Key Vault. Possible values are 'standard' and 'premium'."
  type        = string
  default     = "standard"
}