provider "tfe" {
  token    = var.apitoken
  organization = var.organization_name
}


/*
*
* ADMIN TEAM
*
*/

resource "tfe_project" "adminproject" {
  name = var.prefix+"-Admin"
}

resource "tfe_team" "adminteam" {
  name         = var.prefix+"-admins"
  organization = var.organization_name
  organization_access {
    manage_vcs_settings = true
    manage_workspaces = true
    manage_providers = true
    manage_modules = true
    manage_run_tasks = true
    manage_projects = true
  }
}



/*
*
* SECURITY TEAM
*
*/

resource "tfe_team" "secteam" {
  name         = var.prefix+"-security"
  organization = var.organization_name
  organization_access {
    manage_policies = true
    manage_policy_overrides = true
  }
}



/*
*
* DEVELOPER TEAM
*
*/

resource "tfe_team" "devteam" {
  name         = var.prefix+"-developer"
  organization = var.organization_name
  organization_access {
    manage_policies = true
    manage_policy_overrides = true
  }
}

resource "tfe_organization_membership" "developermembership" {
  organization = var.organization_name
  for_each     = var.developers
  email        = each.key
}

resource "tfe_team_organization_members" "devteammembers" {
  team_id = tfe_team.devteam.id
  organization_membership_ids = [for member in var.developers : tfe_organization_membership.developermembership[member].id]
}