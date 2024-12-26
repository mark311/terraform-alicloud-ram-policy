variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = null
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "RAM Policy"
}

variable "allowed_services" {
  description = "List of services to allow Get/List/Describe/View options. Service name should be the same as corresponding service RAM code"
  type        = list(string)
}

variable "additional_allowed_actions" {
  description = "List of actions if you want to add as supplementary"
  type        = list(string)
  default     = []
}

variable "allow_sls_log_query_actions" {
  description = "Allows log:Query* actions"
  type        = bool
  default     = true
}

variable "allow_predefined_sts_actions" {
  description = "Allows GetCallerIdentity/GetSessionToken/GetAccessKeyInfo sts actions"
  type        = bool
  default     = true
}

variable "allow_web_console_services" {
  description = "Allows List/Get/Describe/View actions for services used when browsing AliCloud console (e.g. resource-groups, tag, health services)"
  type        = bool
  default     = true
}

variable "web_console_services" {
  description = "List of web console services to allow"
  type        = list(string)
  default     = ["resource-groups", "tag", "health", "ce"]
}
