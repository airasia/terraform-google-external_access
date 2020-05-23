Terraform module for managing external accesses using IAM Roles in GCP

**Attention:** This module is meant to provide access to external entities ONLY. This module is not meant for governing IAM roles of ServiceAcounts that are owned by the same project where this module is being used. The proper [service_account terraform module](https://registry.terraform.io/modules/airasia/service_account/google) should be used instead for that purpose which will generate the ServiceAccount in the same project and will grant the necessary IAM roles to it.

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
    ],
  }
  sa_roles = {
    # DO NOT use this variable to pass ServiceAccount emails owned by the same project where the modue is being used.
    # See attetion live above.
    "app-deployer@example-project.iam.gserviceaccount.com" = [
      "roles/storage.objectViewer",
      "roles/appengine.deployer",
    ],
  }
}
```
