/*
*
* Initialize Workspace Scaffolding
*
*/


// HCP Consul Workspace

resource "tfe_workspace" "hcpconsulworkspace" {
  name               = "HCP-Consul-AWS_eu-central-1"
  organization       = var.organization_name
  tag_names          = ["hcp", "aws", "consul", "eucentral1", "tfcmanaged"]
  description        = "Workspace is managed via TFC."
  allow_destroy_plan = true
  auto_apply         = true
  project_id         = tfe_project.networkproject.id
  vcs_repo {
    identifier     = var.ghrepoconsul
    oauth_token_id = var.githuboauthtokenid
  }
  depends_on = [
    tfe_workspace.hvnworkspace
  ]
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


// HVN Workspace

resource "tfe_workspace" "hvnworkspace" {
  name               = "HCP-HashiCorp_Virtual_Network-AWS_eu-central-1"
  organization       = var.organization_name
  tag_names          = ["hcp", "aws", "eucentral1", "tfcmanaged"]
  description        = "Workspace is managed via TFC."
  allow_destroy_plan = true
  auto_apply         = true
  project_id         = tfe_project.networkproject.id
  vcs_repo {
    identifier     = var.ghrepohvn
    oauth_token_id = var.githuboauthtokenid
  }
  remote_state_consumer_ids = [tfe_workspace.hcpconsulworkspace.id]

}

resource "tfe_workspace_variable_set" "hvnworkspacevarset" {
  variable_set_id = var.hcpvarsetid
  workspace_id    = tfe_workspace.hvnworkspace.id
}

resource "tfe_team_access" "hvnworkspaceaccessnetteam" {
  access       = "admin"
  team_id      = tfe_team.netteam.id
  workspace_id = tfe_workspace.hvnworkspace.id
}
