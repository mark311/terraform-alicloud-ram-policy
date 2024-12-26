terraform {
  required_version = ">= 1.0"

  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
      version = ">= 1.220.0"
    }
  }
}

locals {
  resource_name_prefix = "tfmod-ram-policy-read-only-policy"
  allowed_services = [
    "ecs", "acr", "ack", "fc", "ess", "slb", "vpc", "oss",
    "ots", "dms", "nas", "rds", "cms", "log", "ram", "kms",
  ]
}

module "ram-read-only-policy-example" {
  source = "../../modules/read-only-policy"

  policy_name = "${local.resource_name_prefix}-example"
  description = "${local.resource_name_prefix}-example"

  allowed_services             = local.allowed_services
  allow_web_console_services   = true
  allow_predefined_sts_actions = true
  allow_sls_log_query_actions  = true
  additional_allowed_actions   = ["ram:ListRolesForService"]
}
