/*
*
* Initialize Workspace Scaffolding
*
*/



resource "tfe_workspace" "hvnworkspace" {
  name               = "HCP-HashiCorp_Virtual_Network"
  organization       = var.organization_name
  tag_names          = ["hcp", "tfcmanaged"]
  description        = "Workspace is managed via TFC."
  allow_destroy_plan = false
  auto_apply         = true
  execution_mode     = remote
  project_id         = tfe_project.networkproject
  vcs_repo {
    identifier = var.ghrepohvn
    oauth_token_id = var.githuboauthtokenid
  }

}
