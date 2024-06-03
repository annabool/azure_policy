data "azurerm_management_group" "LZ-ROOT" {
  name = "lzroot-MG"
}


 locals {
  allowed_location_params = (file("allowed_location.json"))
#   diag_set_params = file("diag_set.json")
#   policy_assignments = file("policy_assignments.json")
 }

resource "azurerm_management_group_policy_assignment" "example" {
  name                 = "KIRIL"
  display_name = "GEN_Allowed locations"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
  management_group_id  = data.azurerm_management_group.LZ-ROOT.id
  not_scopes = ["/subscriptions/4590de66-9d23-4f12-9f39-0a4aa5d8b42d/resourceGroups/we-ydev-msft-f5-rg"]
  parameters = local.allowed_location_params
  location = var.location
}

# resource "azurerm_management_group_policy_assignment" "diag_set" {
#   name                 = "TF_ANNA_diag_set"
#   policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/951af2fa-529b-416e-ab6e-066fd85ac459"
#   management_group_id  = data.azurerm_management_group.LZ-ROOT.id
#   not_scopes = ["/subscriptions/4590de66-9d23-4f12-9f39-0a4aa5d8b42d/resourceGroups/we-ydev-msft-f5-rg"]
#   parameters = local.diag_set_params
#   location = var.location

#   identity {
#     type = "SystemAssigned"
#   }
# }