variable "create" {
  description = "Whether to create the RAM policy"
  type        = bool
  default     = true
}

variable "policy_name" {
  description = "The name of the policy"
  type        = string
  default     = "RdsFullAccessDenyBuy"
}

variable "policy_name_suffix" {
  description = "The suffix to append to the default name of the policy"
  type        = string
  default     = ""
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "Allow to full access RDS service and deny to buy and renew."
}