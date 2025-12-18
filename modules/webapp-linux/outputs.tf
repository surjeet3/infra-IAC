output "webapp_ids" {
  description = "Map of web app IDs"
  value       = { for k, v in azurerm_linux_web_app.this : k => v.id }
}

output "principal_ids" {
  description = "Map of managed identity principal IDs"
  value       = { for k, v in azurerm_linux_web_app.this : k => v.identity[0].principal_id }
}

output "webapp_names" {
  value = keys(azurerm_linux_web_app.this)
}
