variable "group_roles" {
  description = "Mappings between group email addresses with a list of IAM roles that the group should be granted. See https://cloud.google.com/iam/docs/understanding-roles."
  type        = map(list(string))
  default     = {}
}
