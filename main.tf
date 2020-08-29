terraform {
  required_version = ">= 0.13.1" # see https://releases.hashicorp.com/terraform/
}

provider "google" {
  version = ">= 3.13.0" # see https://github.com/terraform-providers/terraform-provider-google/releases
}

locals {
  group_roles = flatten([
    for group_email, roles in var.group_roles : [
      for role in roles : {
        group_email = group_email
        role        = role
  }]])

  sa_roles = flatten([
    for sa_email, roles in var.sa_roles : [
      for role in roles : {
        sa_email = sa_email
        role     = role
  }]])
}

resource "google_project_iam_member" "group_access" {
  count  = length(local.group_roles)
  role   = local.group_roles[count.index].role
  member = "group:${local.group_roles[count.index].group_email}"
}

resource "google_project_iam_member" "service_account_access" {
  count  = length(local.sa_roles)
  role   = local.sa_roles[count.index].role
  member = "serviceAccount:${local.sa_roles[count.index].sa_email}"
}
