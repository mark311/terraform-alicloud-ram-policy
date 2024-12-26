resource "alicloud_ram_policy" "policy" {
  count = var.create ? 1 : 0

  policy_name = var.policy_name
  description = var.description

  policy_document = data.alicloud_ram_policy_document.all-in-one.document
}

locals {
  # the following lists has only 1 element if corresponding actions is
  # not empty, otherwise has 0 element.
  allowed_actions_common_prefix_dynamic_flags         = length(var.allowed_services) > 0 ? [1,] : []
  allowed_console_actions_common_prefix_dynamic_flags = var.allow_web_console_services ? [1,] : []
  allowed_predefined_sts_actions_dynamic_flags        = var.allow_predefined_sts_actions ? [1,] : []
  allowed_sls_log_query_actions_dynamic_flags         = var.allow_sls_log_query_actions ? [1,] : []
  additional_allowed_actions_dynamic_flags            = length(var.additional_allowed_actions) > 0 ? [1,] : []

  allowed_services = distinct(var.allowed_services)

  allowed_actions_common_prefix = sort(distinct(flatten([for s in local.allowed_services: [
    "${s}:Get*",
    "${s}:List*",
    "${s}:Describe*",
    "${s}:View*",
  ]])))

  allowed_console_actions_common_prefix = sort(distinct(flatten([for s in var.web_console_services: [
    "${s}:Get*",
    "${s}:List*",
    "${s}:Describe*",
    "${s}:View*",
  ]])))

}

data "alicloud_ram_policy_document" "all-in-one" {

  # allowed services' read only actions
  dynamic "statement" {
    for_each = local.allowed_actions_common_prefix_dynamic_flags

    content {
      action = local.allowed_actions_common_prefix
      resource = ["*"]
    }
  }

  # web console services' read only actions
  dynamic "statement" {
    for_each = local.allowed_console_actions_common_prefix_dynamic_flags

    content {
      action = local.allowed_console_actions_common_prefix
      resource = ["*"]
    }
  }

  dynamic "statement" {
    for_each = local.allowed_predefined_sts_actions_dynamic_flags

    content {
      action = [
        "sts:GetCallerIdentity",
      ]
      resource = ["*"]
    }
  }

  # actions in AliyunLogReadOnlyAccess that are not provided by above
  # "allowed_service" policy document
  dynamic "statement" {
    for_each = local.allowed_sls_log_query_actions_dynamic_flags

    content {
      action = [
        "log:Query*"
      ]
      resource = ["*"]
    }
  }

  dynamic "statement" {
    for_each = local.additional_allowed_actions_dynamic_flags

    content {
      action = var.additional_allowed_actions
      resource = ["*"]
    }
  }
}
