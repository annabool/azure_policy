data "azurerm_management_group" "LZ-ROOT" {
  name = "lzroot-MG"
}


locals {
  allowed_location_params = jsondecode(file("allowed_location.json"))
  diag_set_params = file("diag_set.json")
}

resource "azurerm_management_group_policy_assignment" "example" {
  name                 = "example-policy"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
  management_group_id  = data.azurerm_management_group.LZ-ROOT.id
  not_scopes = ["/subscriptions/4590de66-9d23-4f12-9f39-0a4aa5d8b42d/resourceGroups/we-ydev-msft-f5-rg"]
  parameters = jsonencode(local.allowed_location_params.anna)
  location = var.location
}

resource "azurerm_management_group_policy_assignment" "diag_set" {
  name                 = "TF_ANNA_diag_set"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/951af2fa-529b-416e-ab6e-066fd85ac459"
  management_group_id  = data.azurerm_management_group.LZ-ROOT.id
  not_scopes = ["/subscriptions/4590de66-9d23-4f12-9f39-0a4aa5d8b42d/resourceGroups/we-ydev-msft-f5-rg"]
  parameters = local.diag_set_params
  location = var.location

  identity {
    type = "SystemAssigned"
  }
}


resource "azurerm_subscription_policy_assignment" "sub_diag_set" {
  name                 = "SUB_TF_ANNA_diag_set"
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/951af2fa-529b-416e-ab6e-066fd85ac459"
  subscription_id  = "/subscriptions/fe7276bf-b23b-413e-8279-be285e56c0e9"
  #not_scopes = ["/subscriptions/4590de66-9d23-4f12-9f39-0a4aa5d8b42d/resourceGroups/we-ydev-msft-f5-rg"]
  parameters = local.diag_set_params
  location = var.location

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_subscription_policy_remediation" "example" {
  name                 = "SUB_TF_ANNA_REME"
  subscription_id      = "/subscriptions/fe7276bf-b23b-413e-8279-be285e56c0e9"
  policy_assignment_id = "/providers/Microsoft.Authorization/policyDefinitions/951af2fa-529b-416e-ab6e-066fd85ac459"
}

# resource "azurerm_role_assignment" "example" {
#   principal_id   = azurerm_policy_assignment.example.identity[0].principal_id
#   scope          = azurerm_management_group.example.id
#   role_definition_name = "Contributor"
#   depends_on = [azurerm_policy_assignment.example]
# }