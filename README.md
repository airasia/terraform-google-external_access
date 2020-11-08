Terraform module for managing external accesses using IAM Roles in GCP

**Attention:** This module is meant to provide access to external entities ONLY. This module is not meant for governing IAM roles of ServiceAcounts that are owned by the same project where this module is being used. The proper [service_account terraform module](https://registry.terraform.io/modules/airasia/service_account/google) should be used instead for that purpose which will generate the ServiceAccount in the same project and will grant the necessary IAM roles to it.

```terraform
module "external_access" {
  source      = "airasia/external_access/google"
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
    # DO NOT use this variable to pass ServiceAccount emails owned by the same project where this module is being used.
    # See attention line above.
    "app-deployer@example-project.iam.gserviceaccount.com" = [
      "roles/storage.objectViewer",
      "roles/appengine.deployer",
    ],
  }
}
```

# Upgrade guide from v2.0.0 to v2.1.0

First make sure you've planned & applied `v2.0.0`. Then, upon upgrading from `v2.0.0` to `v2.1.0`, you may (or may not) see a plan that destroys & creates an equal number of `google_project_iam_member` resources. It is OK to apply these changes as it will only change the data-structure of these resources [from an array to a hashmap](https://github.com/airasia/terraform-google-external_access/wiki/The-problem-of-%22shifting-all-items%22-in-an-array). Note that, after you plan & apply these changes, you may (or may not) get a **"Provider produced inconsistent result after apply"** error. Just re-plan and re-apply and that would resolve the error.
