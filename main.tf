provider "tfe" {
  token    = var.apitoken
  organization = var.organization_name
}

/*
*
* PROJECT STRUCTURE
*
*/

resource "tfe_project" "hcpproject" {
  name = "${var.prefix}-HCP"
}

resource "tfe_project" "awsproject" {
  name = "${var.prefix}-AWS"
}


/*
*
* NETWORK TEAM
*
*/

resource "tfe_team" "netteam" {
  name         = "${var.prefix}-network"
  organization = var.organization_name
  organization_access {
    manage_policies = false
    manage_policy_overrides = false
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