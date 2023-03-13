variable "apitoken" {
  description = "Token for TF API"
  sensitive   = true
}

variable "organization_name" {
  description = "Name of the organization"
}

variable "prefix" {
  description = "prefix for all resources"
}

variable "developers" {
  description = "Set of developer usernames"
  type        = set(string)
}

variable "githuboauthtokenid" {
  description = "The OAuth Token ID for Github"
  type        = string

}

variable "hcpvarsetid" {
    description = "ID of the VariableSet which has the HCP Credentials"
    type = string
    sensitive = true
}

variable "ghrepohvn" {
    default = "cduch/DEMO-hcp-hvn"
}

variable "ghrepovault" {
    default = "cduch/DEMO-hcp-vault"
}
