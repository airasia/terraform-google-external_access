Terraform module for managing Group IAM Roles in GCP

```terraform
module "group_access" {
  source      = "airasia/group_access/google"
  version     = "1.0.1"
  group_roles = {
    "developers@example.com" = [
      "roles/appengine.deployer",
      "roles/cloudsql.viewer",
      "roles/cloudsql.client"
    ],
    "admins@example.com" = [
      "roles/appengine.appAdmin",
      "roles/cloudsql.admin"
    ]
  }
}
```
