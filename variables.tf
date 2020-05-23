variable "group_roles" {
  description = "Mappings between group email addresses with a list of IAM roles that the group should be granted. See https://cloud.google.com/iam/docs/understanding-roles."
  type        = map(list(string))
  default     = {}
}

variable "sa_roles" {
  description = "Mappings between \"external\" ServiceAccount email addresses with a list of IAM roles that the \"external\" ServiceAccount should be granted. DO NOT use the \"sa_roles\" variable to pass ServiceAccount emails owned by the same project where this module is being used. You should use the proper \"service_account\" terraform module for that purpose instead to generate the SA and to grant necessary IAM roles to it. See https://cloud.google.com/iam/docs/understanding-roles."
  type        = map(list(string))
  default     = {}
}
