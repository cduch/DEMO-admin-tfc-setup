/*
*
* Initialize Workspace Scaffolding
*
*/



resource "tfe_workspace" "hvnworkspace" {
  name               = "HCP-HashiCorp_Virtual_Network-AWS_eu-central-1"
  organization       = var.organization_name
  tag_names          = ["hcp", "aws","eucentral1","tfcmanaged"]
  description        = "Workspace is managed via TFC."
  allow_destroy_plan = false
  auto_apply         = true
  project_id         = tfe_project.networkproject.id
  vcs_repo {
    identifier = var.ghrepohvn
    oauth_token_id = var.githuboauthtokenid
  }

}

resource "tfe_workspace_variable_set" "hvnworkspacevarset" {
  variable_set_id = var.hcpvarsetid
  workspace_id    = tfe_workspace.hvnworkspace.id
}