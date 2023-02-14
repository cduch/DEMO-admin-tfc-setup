variable "apitoken" {
    description = "Token for TF API"
}

variable "organization_name" {
  description = "Name of the organization"
}

variable "prefix" {
    description = "prefix for all resources"
}

variable developers {
    description = "Set of developers"
    type = set(string)
}