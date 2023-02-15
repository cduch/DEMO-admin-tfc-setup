provider "tfe" {
  token    = var.apitoken
  organization = var.organization_name
}

/*
*
* PROJECT STRUCTURE
*
*/

resource "tfe_project" "adminproject" {
  name = "${var.prefix}-Admin"
}

resource "tfe_project" "securityproject" {
  name = "${var.prefix}-Security"
}

resource "tfe_project" "networkproject" {
  name = "${var.prefix}-Network"
}

resource "tfe_project" "awsproject" {
  name = "${var.prefix}-AWS"
}

resource "tfe_project" "azureproject" {
  name = "${var.prefix}-AZURE"
}

resource "tfe_project" "dcproject" {
  name = "${var.prefix}-DC"
}

/*
*
* ADMIN TEAM
*
*/

resource "tfe_team" "adminteam" {
  name         = "${var.prefix}-admins"
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
  name         = "${var.prefix}-security"
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
  name         = "${var.prefix}-developer"
  organization = var.organization_name
  organization_access {
    manage_policies = false
    manage_policy_overrides = false
  }
}

resource "tfe_team_members" "devteammembers" {
  team_id   = tfe_team.devteam.id
  usernames = [for user in var.developers : user]
}