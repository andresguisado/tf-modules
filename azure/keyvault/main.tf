resource "azurerm_resource_group" "rg_keyvault" {
  name     = "${var.rg_name}"
  location = "${var.location}"
}

resource "azurerm_key_vault" "keyvault" {
  name                        = "${var.kv_name}"
  location                    = "${azurerm_resource_group.rg_keyvault.location}"
  resource_group_name         = "${azurerm_resource_group.rg_keyvault.name}"
  enabled_for_disk_encryption = true
  tenant_id                   = "${var.tenant_id}"

  sku {
    name = "standard"
  }

  access_policy {
    tenant_id = "${var.tenant_id}"
    object_id = "${var.object_id_1}"

    key_permissions = [
      "get",
      "create",
      "delete",
      "list",
      "purge",
      "recover",
      "restore",
    ]

    secret_permissions = [
      "get",
      "delete",
      "set",
      "list",
      "purge",
      "recover",
      "restore",
    ]
  }

  access_policy {
    tenant_id = "${var.tenant_id}"
    object_id = "${var.object_id_2}"

    key_permissions = [
      "get",
      "delete",
      "list",
      "purge",
      "recover",
      "restore",
      "create",
    ]

    secret_permissions = [
      "get",
      "delete",
      "list",
      "purge",
      "recover",
      "restore",
      "set",
    ]
  }

  tags {
    environment = "Production"
  }
}