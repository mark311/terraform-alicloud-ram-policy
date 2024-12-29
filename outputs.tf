output "this_policy_id" {
  description = "(Deprecated, use 'policy_id') Id of the custom policy"
  value       = alicloud_ram_policy.policy_with_actions.*.id
}

output "this_policy_name" {
  description = "(Deprecated, use 'policy_name') Name of the custom policy"
  value       = alicloud_ram_policy.policy_with_actions.*.name
}

output "policy_id" {
  description = "Id of the custom policy"
  value       = alicloud_ram_policy.policy_with_actions.*.id
}

output "policy_name" {
  description = "Name of the custom policy"
  value       = alicloud_ram_policy.policy_with_actions.*.name
}
