output "spn_app_id" {
  value       = "${azurerm_azuread_application.app_spn.application_id}"
}
output "spn_password" {
  value       = "${azurerm_azuread_service_principal_password.app_spn_password.value}"
}

output "spn_principal" {
  value       = "${azurerm_azuread_service_principal.app_spn_id.id}"
}

output "spn_object_id" {
  value       = "${azurerm_azuread_application.app_spn.id}"
}
