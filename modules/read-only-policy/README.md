<!-- 在根目录下运行命令 `terraform-docs markdown . --output-file "./README.md"`，可将所有信息自动填充 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.220.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.220.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_policy.policy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_policy_document.all-in-one](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/data-sources/ram_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_allowed_actions"></a> [additional\_allowed\_actions](#input\_additional\_allowed\_actions) | List of actions if you want to add as supplementary | `list(string)` | `[]` | no |
| <a name="input_allow_predefined_sts_actions"></a> [allow\_predefined\_sts\_actions](#input\_allow\_predefined\_sts\_actions) | Allows GetCallerIdentity/GetSessionToken/GetAccessKeyInfo sts actions | `bool` | `true` | no |
| <a name="input_allow_sls_log_query_actions"></a> [allow\_sls\_log\_query\_actions](#input\_allow\_sls\_log\_query\_actions) | Allows log:Query* actions | `bool` | `true` | no |
| <a name="input_allow_web_console_services"></a> [allow\_web\_console\_services](#input\_allow\_web\_console\_services) | Allows List/Get/Describe/View actions for services used when browsing AliCloud console (e.g. resource-groups, tag, health services) | `bool` | `true` | no |
| <a name="input_allowed_services"></a> [allowed\_services](#input\_allowed\_services) | List of services to allow Get/List/Describe/View options. Service name should be the same as corresponding service RAM code | `list(string)` | n/a | yes |
| <a name="input_create_policy"></a> [create\_policy](#input\_create\_policy) | Whether to create the RAM policy | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the policy | `string` | `"RAM Policy"` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | The name of the policy | `string` | `null` | no |
| <a name="input_web_console_services"></a> [web\_console\_services](#input\_web\_console\_services) | List of web console services to allow | `list(string)` | <pre>[<br/>  "resource-groups",<br/>  "tag",<br/>  "health",<br/>  "ce"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_description"></a> [description](#output\_description) | The description of the policy |
| <a name="output_id"></a> [id](#output\_id) | The policy's ID |
| <a name="output_policy_document"></a> [policy\_document](#output\_policy\_document) | The policy document |
| <a name="output_policy_json"></a> [policy\_json](#output\_policy\_json) | Policy document as json. Useful if you need document but do not want to create IAM policy itself. For example for CloudSSO Permission Set inline policies |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | The name of the policy |
<!-- END_TF_DOCS -->
