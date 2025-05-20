output "acr_login_server" {
  description = "The URL of the Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  description = "The admin username of the Azure Container Registry"
  value       = azurerm_container_registry.acr.admin_username
}

output "container_fqdn" {
  description = "The FQDN of the container instance"
  value       = "http://${azurerm_container_group.aci.fqdn}:8080"
}