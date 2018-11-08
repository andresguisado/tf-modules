# AKS Terraform Module
resource "azurerm_resource_group" "aks" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
  tags     = "${var.tags}"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.aks_cluster_name}"
  location            = "${azurerm_resource_group.aks.location}"
  resource_group_name = "${azurerm_resource_group.aks.name}"
  dns_prefix          = "${var.dns_prefix}"

  kubernetes_version = "${var.kubernetes_version}"

  linux_profile {
    admin_username = "${var.linux_profile_admin_username}"

    ssh_key {
      key_data = "${var.linux_profile_ssh_key}"
    }
  }

  agent_pool_profile {
    name    = "${var.agent_pool_profile_name}"
    count   = "${var.agent_pool_count}"
    vm_size = "${var.agent_pool_vm_size}"
    os_type = "${var.agent_pool_os_type}"

    // vnet_subnet_id  = "${var.agent_vnet_subnet_id}"
  }

  service_principal {
    client_id     = "${var.service_principal_client_id}"
    client_secret = "${var.service_principal_client_secret}"
  }

  tags = "${var.tags}"
}
