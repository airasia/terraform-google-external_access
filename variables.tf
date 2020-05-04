variable "group_roles" {
  description = "Mappings between group email addresses and list of IAM roles that each of the groups should be granted. See https://cloud.google.com/iam/docs/understanding-roles."
  type        = map(list(string))
}
