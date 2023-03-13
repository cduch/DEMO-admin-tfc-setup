/*
*
* Initialize Workspace Scaffolding
*
*/


// HVN  Workspace

resource "tfe_workspace" "hvnworkspace" {
  name               = "HCP_HVN"
  organization       = var.organization_name
  tag_names          = ["hcp", "hvn","tfcmanaged"]
  description        = "Deploys a HVN in HCP. Workspace was automatically created."
  allow_destroy_plan = true
  auto_apply         = true
  project_id         = tfe_project.hcpproject.id
  vcs_repo {
    identifier     = var.ghrepohvn
    oauth_token_id = var.githuboauthtokenid
  }
}

resource "tfe_workspace_variable_set" "hcpvarset" {
  variable_set_id = var.hcpvarsetid
  workspace_id    = tfe_workspace.hvnworkspace.id
}

resource "tfe_team_access" "hvnworkspaceaccessnetteam" {
  access       = "admin"
  team_id      = tfe_team.netteam.id
  workspace_id = tfe_workspace.hvnworkspace.id
}

