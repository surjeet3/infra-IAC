locals {
  resource_suffix = "${var.app}-${var.env}-${var.location_short}"
}

output "app_service_plan" {
  value = "asp-${local.resource_suffix}"
}

output "webapp" {
  value = "app-${local.resource_suffix}-${var.instance}"
}

output "private_endpoint" {
  value = "pe-${local.resource_suffix}-${var.instance}"
}
