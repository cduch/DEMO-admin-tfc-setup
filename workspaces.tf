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
  global_remote_state = true
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



// Vault Workspace


resource "tfe_workspace" "vaultworkspace" {
  name               = "HCP_Vault"
  organization       = var.organization_name
  tag_names          = ["hcp", "vault","tfcmanaged"]
  description        = "Deploys Vault in HCP. Workspace was automatically created."
  allow_destroy_plan = true
  auto_apply         = true
  project_id         = tfe_project.hcpproject.id
  vcs_repo {
    identifier     = var.ghrepovault
    oauth_token_id = var.githuboauthtokenid
  }
}

resource "tfe_workspace_variable_set" "vaultvarset" {
  variable_set_id = var.hcpvarsetid
  workspace_id    = tfe_workspace.vaultworkspace.id
}



resource "tfe_team_access" "vaultworkspaceaccesssecteam" {
  access       = "admin"
  team_id      = tfe_team.secteam.id
  workspace_id = tfe_workspace.vaultworkspace.id
}


// Consul Workspace

resource "tfe_workspace" "consulworkspace" {
  name               = "HCP_Consul"
  organization       = var.organization_name
  tag_names          = ["hcp", "consul","tfcmanaged"]
  description        = "Deploys Consul in HCP. Workspace was automatically created."
  allow_destroy_plan = true
  auto_apply         = true
  project_id         = tfe_project.hcpproject.id
  global_remote_state = true
  vcs_repo {
    identifier     = var.ghrepoconsul
    oauth_token_id = var.githuboauthtokenid
  }
}

resource "tfe_workspace_variable_set" "consulvarset" {
  variable_set_id = var.hcpvarsetid
  workspace_id    = tfe_workspace.consulworkspace.id
}

resource "tfe_team_access" "consulworkspaceaccessnetteam" {
  access       = "admin"
  team_id      = tfe_team.netteam.id
  workspace_id = tfe_workspace.consulworkspace.id
}