variable "resource_group_name" {}
variable "location" {}
variable "environment" {}
variable "subnet_id_web" {}
variable "subnet_id_webinbound" {}
# variable "acr_id" {}
# variable "keyvault_id" {}
variable "base_name" {}
variable "tags" {}

variable "apps" {
  type = map(object({
    image_name     = string
    image_tag      = string
    plan_name  = optional(string)
    # db_secret_uri  = string
    # api_secret_uri = string
  }))
}
