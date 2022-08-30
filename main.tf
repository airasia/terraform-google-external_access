terraform {
  required_version = ">= 0.13.1" # see https://releases.hashicorp.com/terraform/
}

data "google_client_config" "google_client" {}

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
  for_each = { for obj in local.group_roles : "${obj.group_email}---${obj.role}" => obj if obj.role != "roles/owner" }
  project  = data.google_client_config.google_client.project
  role     = each.value.role
  member   = "group:${each.value.group_email}"
}

resource "google_project_iam_member" "service_account_access" {
  for_each = { for obj in local.sa_roles : "${obj.sa_email}---${obj.role}" => obj if obj.role != "roles/owner" }
  project  = data.google_client_config.google_client.project
  role     = each.value.role
  member   = "serviceAccount:${each.value.sa_email}"
}
