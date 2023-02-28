/*
*
* Initialize Workspace Scaffolding
*
*/


// HCP  Workspace

resource "tfe_workspace" "hcpworkspace" {
  name               = "HCP_Stack"
  organization       = var.organization_name
  tag_names          = ["hcp", "tfcmanaged"]
  description        = "Workspace is managed via TFC."
  allow_destroy_plan = true
  auto_apply         = false
  project_id         = tfe_project.hcpproject.id
  vcs_repo {
    identifier     = var.ghrepohcp
    oauth_token_id = var.githuboauthtokenid
  }
}

resource "tfe_workspace_variable_set" "hcpconsulworkspacevarset" {
  variable_set_id = var.hcpvarsetid
  workspace_id    = tfe_workspace.hcpconsulworkspace.id
}

resource "tfe_team_access" "hcpconsulworkspaceaccessnetteam" {
  access       = "admin"
  team_id      = tfe_team.netteam.id
  workspace_id = tfe_workspace.hcpconsulworkspace.id
}

