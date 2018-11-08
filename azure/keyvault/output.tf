output "vault_id" {
  value       = "${azurerm_key_vault.keyvault.id}"
}
output "vault_uri" {
  value       = "${azurerm_key_vault.keyvault.vault_uri}"
}

output "vault_name" {
  value       = "${azurerm_key_vault.keyvault.name}"
}