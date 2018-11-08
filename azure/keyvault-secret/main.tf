resource "azurerm_key_vault_secret" "secret" {
  name      = "${var.name}"
  value     = "${var.value}"
  vault_uri = "${var.vault_uri}"

  tags {
    environment = "Production"
  }
}