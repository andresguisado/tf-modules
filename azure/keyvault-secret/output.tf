output "secret_id" {
  value       = "${azurerm_key_vault_secret.secret.id}"
}
output "secret_version" {
  value       = "${azurerm_key_vault_secret.secret.version}"
}
