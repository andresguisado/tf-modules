resource "azurerm_azuread_application" "app_spn" {
  name                       = "${var.spn_name}"
  available_to_other_tenants = true
  oauth2_allow_implicit_flow = false
}

resource "azurerm_azuread_service_principal" "app_spn_id" {
  application_id = "${azurerm_azuread_application.app_spn.application_id}"
}

/*resource "null_resource" "wait_for_spn"{
  depends_on           = ["azurerm_azuread_service_principal.app_spn_id"]
  provisioner "local-exec" {
    command = <<EOT
     NEXT_WAIT_TIME=0
     echo "Querying for ${azurerm_azuread_service_principal.app_spn_id.id}..."
     until az ad sp show --id ${azurerm_azuread_service_principal.app_spn_id.id} > /dev/null 2>&1 || [[ $NEXT_WAIT_TIME -eq 36 ]]; do
        echo "Waiting for service principal creation: NEXT_WAIT_TIME"
        sleep $(( NEXT_WAIT_TIME++ ))
     done
EOT
  }
}*/

resource "azurerm_azuread_service_principal_password" "app_spn_password" {
  //depends_on           = ["null_resource.wait_for_spn"]
  service_principal_id = "${azurerm_azuread_service_principal.app_spn_id.id}"
  value                = "${random_string.password.result}"
  end_date             = "${var.spn_end_date}" #2020-01-01T01:02:03Z  
}

/*resource "null_resource" "wait_for_spn_password"{
  depends_on           = ["azurerm_azuread_service_principal_password.app_spn_password"]
  provisioner "local-exec" {
    command = <<EOT
     NEXT_WAIT_TIME=0
     echo "Querying for ${azurerm_azuread_service_principal.app_spn_id.id} password ..."
     until az ad sp credential list --id ${azurerm_azuread_service_principal.app_spn_id.id} > /dev/null 2>&1 || [[ $NEXT_WAIT_TIME -eq 36 ]]; do
        echo "Waiting for service principal password creation: NEXT_WAIT_TIME"
        sleep $(( NEXT_WAIT_TIME++ ))
     done
EOT
  }
}*/

########                      Assign azure role to SPN                  ######################################
######## BUG still open: https://github.com/terraform-providers/terraform-provider-azurerm/issues/1635  ######
########      This is related to the time to replicate the SP through the Azure AD servers.             ######
########                            INFO                                                                ######
# Az CLI behaviour: API call is paused for 5 sec and it retries role assignment 36 times  
# Workarounds by using the following: 
#    * local-exec - sleep 30s,60s,180s,200s.. it didn't work 
#    * local-exec -  az-cli to assign role to the SPN. it works!
# Solutions?:
#    * adding a "max_tries" option to AzureRM provider as AWS provider does.
###############################################################################################################

//resource "azurerm_role_assignment" "app_spn_role" {
//  scope                = "${var.spn_scope}" #/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
//  role_definition_name = "${var.spn_role_definition_name}"
//  principal_id         = "${azurerm_azuread_service_principal.app_spn_id.id}"
//}

resource "random_string" "password" {
  length = 32
  special = true
  override_special = "%@+#="
}
