Terraform module which create RAM policies on Alibaba Cloud.   
terraform-alicloud-ram-policy

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/blob/master/README-CN.md)

Terraform module can create custom policies on Alibaba Cloud.

These types of resources are supported:

* [RAM policy](https://www.terraform.io/docs/providers/alicloud/r/ram_policy.html)

## Usage

```hcl
module "ram-policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    #########################################
    # Create policies using default actions #
    #########################################
    {
       # name is the name of the policy, default to a name with prefix `terraform-ram-policy-`
       name = "test"
       # defined_action is the default resource operation specified by the system. You can refer to the `policies.tf` file.
       defined_actions = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
       effect          = "Allow"
       force           = "true"
    },

    ########################################
    # Create policies using custom actions #
    ########################################
    {
        #actions is the action of custom specific resource.
        #resources is the specific object authorized to customize.
        actions   = join(",", ["ecs:ModifyInstanceAttribute", "vpc:ModifyVpc", "vswitch:ModifyVSwitch"])
        resources = join(",", ["acs:ecs:*:*:instance/i-001", "acs:vpc:*:*:vpc/v-001", "acs:vpc:*:*:vswitch/vsw-001"])
        effect    = "Deny"
    },
    
    #########################################################
    # Create policies using both default and custom actions #
    #########################################################  
    {
        defined_actions = join(",", ["security-group-read", "security-group-rule-read"])
        actions         = join(",", ["ecs:JoinSecurityGroup", "ecs:LeaveSecurityGroup"])
        resources       = join(",", ["acs:ecs:cn-qingdao:*:instance/*", "acs:ecs:cn-qingdao:*:security-group/*"])
        effect          = "Allow"
    }
  ]
}
```

## Examples

* [Complete Ram Policy example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-policy/tree/master/examples/complete)

## Notes
From the version v1.1.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  version                 = ">=1.64.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ram-policy"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.0.0:

```hcl
module "ram-policy" {
  source   = "terraform-alicloud-modules/ram-policy/alicloud"
  version  = "1.0.0"
  region   = "cn-shenzhen"
  profile  = "Your-Profile-Name"
  policies = [
    {
      name            = "test"
      defined_actions = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
      effect          = "Allow"
      force           = "true"
    }
  ]
  // ...
}
```

If you want to upgrade the module to 1.1.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
  region  = "cn-shenzhen"
  profile = "Your-Profile-Name"
}
module "ram-policy" {
  source   = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
      name            = "test"
      defined_actions = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
      effect          = "Allow"
      force           = "true"
    }
  ]
  // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
  region  = "cn-shenzhen"
  profile = "Your-Profile-Name"
  alias   = "sz"
}
module "ram-policy" {
  source   = "terraform-alicloud-modules/ram-policy/alicloud"
  providers         = {
    alicloud = alicloud.sz
  }
  policies = [
    {
      name            = "test"
      defined_actions = join(",", ["instance-create", "vpc-create", "vswitch-create", "security-group-create"])
      effect          = "Allow"
      force           = "true"
    }
  ]
  // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

<!-- 在根目录下运行命令 `terraform-docs markdown . --output-file "./README.md"`，可将所有信息自动填充 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_policy.policy_with_actions](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether to create RAM policies. If true, the policies should not be empty. | `bool` | `true` | no |
| <a name="input_defined_actions"></a> [defined\_actions](#input\_defined\_actions) | Map of several defined actions | `map(list(string))` | <pre>{<br/>  "db-instance-all": [<br/>    "rds:*Instance*",<br/>    "rds:ModifyParameter",<br/>    "rds:UntagResources",<br/>    "rds:TagResources",<br/>    "rds:ModifySecurityGroupConfiguration",<br/>    "rds:DescribeTags",<br/>    "rds:DescribeSQLCollector*",<br/>    "rds:DescribeParameters",<br/>    "rds:DescribeSecurityGroupConfiguration"<br/>  ],<br/>  "db-instance-create": [<br/>    "rds:CreateDBInstance",<br/>    "vpc:DescribeVSwitchAttributes",<br/>    "rds:ModifyParameter",<br/>    "rds:UntagResources",<br/>    "rds:TagResources",<br/>    "rds:ModifyInstanceAutoRenewalAttribute",<br/>    "rds:ModifySecurityGroupConfiguration",<br/>    "rds:ModifyDBInstance*",<br/>    "rds:DescribeDBInstance*",<br/>    "rds:DescribeTags",<br/>    "rds:DescribeSQLCollector*",<br/>    "rds:DescribeParameters",<br/>    "rds:DescribeInstanceAutoRenewalAttribute",<br/>    "rds:DescribeSecurityGroupConfiguration"<br/>  ],<br/>  "db-instance-delete": [<br/>    "rds:DeleteDBInstance",<br/>    "rds:DescribeDBInstanceAttribute"<br/>  ],<br/>  "db-instance-read": [<br/>    "rds:DescribeDBInstance*",<br/>    "rds:DescribeTags",<br/>    "rds:DescribeSQLCollector*",<br/>    "rds:DescribeParameters",<br/>    "rds:DescribeInstanceAutoRenewalAttribute",<br/>    "rds:DescribeSecurityGroupConfiguration"<br/>  ],<br/>  "db-instance-update": [<br/>    "rds:ModifyParameter",<br/>    "rds:UntagResources",<br/>    "rds:TagResources",<br/>    "rds:ModifyInstanceAutoRenewalAttribute",<br/>    "rds:ModifySecurityGroupConfiguration",<br/>    "rds:ModifyDBInstance*",<br/>    "rds:DescribeDBInstance*",<br/>    "rds:DescribeTags",<br/>    "rds:DescribeSQLCollector*",<br/>    "rds:DescribeParameters",<br/>    "rds:DescribeInstanceAutoRenewalAttribute",<br/>    "rds:DescribeSecurityGroupConfiguration"<br/>  ],<br/>  "disk-all": [<br/>    "ecs:*Disk*",<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:DescribeZones"<br/>  ],<br/>  "disk-attach": [<br/>    "ecs:AttachDisk",<br/>    "ecs:DescribeDisks",<br/>    "ecs:ModifyDiskAttribute"<br/>  ],<br/>  "disk-create": [<br/>    "ecs:CreateDisk",<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:ModifyDiskAttribute",<br/>    "ecs:DescribeDisks",<br/>    "ecs:DescribeZones"<br/>  ],<br/>  "disk-delete": [<br/>    "ecs:DeleteDisk",<br/>    "ecs:DescribeDisks"<br/>  ],<br/>  "disk-detach": [<br/>    "ecs:DetachDisk",<br/>    "ecs:DescribeDisks"<br/>  ],<br/>  "disk-read": [<br/>    "ecs:DescribeDisks"<br/>  ],<br/>  "disk-update": [<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:ModifyDiskAttribute",<br/>    "ecs:ResizeDisk",<br/>    "ecs:DescribeDisks"<br/>  ],<br/>  "eip-all": [<br/>    "vpc:*EipAddress*",<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources"<br/>  ],<br/>  "eip-associate": [<br/>    "vpc:AssociateEipAddress",<br/>    "vpc:DescribeEipAddresses"<br/>  ],<br/>  "eip-create": [<br/>    "vpc:AllocateEipAddress",<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ModifyEipAddressAttribute",<br/>    "vpc:DescribeEipAddresses"<br/>  ],<br/>  "eip-delete": [<br/>    "vpc:ReleaseEipAddress",<br/>    "vpc:DescribeEipAddresses"<br/>  ],<br/>  "eip-read": [<br/>    "vpc:DescribeEipAddresses"<br/>  ],<br/>  "eip-unassociate": [<br/>    "vpc:UnassociateEipAddress",<br/>    "vpc:DescribeEipAddresses"<br/>  ],<br/>  "eip-update": [<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ModifyEipAddressAttribute",<br/>    "vpc:DescribeEipAddresses"<br/>  ],<br/>  "image-all": [<br/>    "ecs:*Image*",<br/>    "ecs:DescribeInstances",<br/>    "ecs:DescribeSnapshots"<br/>  ],<br/>  "image-copy": [<br/>    "ecs:CopyImage",<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "image-create": [<br/>    "ecs:DescribeInstances",<br/>    "ecs:DescribeSnapshots",<br/>    "ecs:CreateImage",<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "image-delete": [<br/>    "ecs:DeleteImage",<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "image-export": [<br/>    "ecs:ExportImage",<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "image-import": [<br/>    "ecs:ImportImage",<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "image-read": [<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "image-share": [<br/>    "ecs:*ImageSharePermission"<br/>  ],<br/>  "image-update": [<br/>    "ecs:ModifyImageAttribute",<br/>    "ecs:DescribeImages"<br/>  ],<br/>  "instance-all": [<br/>    "ecs:*Instance*",<br/>    "ecs:TagResources",<br/>    "ecs:UntagResources",<br/>    "ecs:DecribeInstance*",<br/>    "ecs:JoinSecurityGroup",<br/>    "ecs:LeaveSecurityGroup",<br/>    "ecs:AttachKeyPair",<br/>    "ecs:ReplaceSystemDisk",<br/>    "ecs:AllocatePublicIpAddress",<br/>    "ecs:DescribeUserData"<br/>  ],<br/>  "instance-create": [<br/>    "ecs:DescribeAvailableResource",<br/>    "vpc:DescribeVSwitchAttributes",<br/>    "ecs:DescribeZones",<br/>    "ecs:DescribeSecurityGroupAttribute",<br/>    "ecs:RunInstances",<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:DescribeDisks",<br/>    "ecs:JoinSecurityGroup",<br/>    "ecs:LeaveSecurityGroup",<br/>    "kms:Decrypt",<br/>    "ecs:ModifyInstanceAutoReleaseTime",<br/>    "ecs:ModifyInstanceAutoRenewAttribute",<br/>    "ecs:DescribeInstances",<br/>    "ecs:DescribeUserData",<br/>    "ecs:DescribeInstanceRamRole",<br/>    "ecs:DescribeInstanceAutoRenewAttribute"<br/>  ],<br/>  "instance-delete": [<br/>    "ecs:DeleteInstance",<br/>    "ecs:ModifyInstanceChargeType",<br/>    "ecs:StopInstance",<br/>    "ecs:DescribeInstances"<br/>  ],<br/>  "instance-read": [<br/>    "ecs:DescribeInstances",<br/>    "ecs:DescribeUserData",<br/>    "ecs:DescribeInstanceRamRole",<br/>    "ecs:DescribeInstanceAutoRenewAttribute"<br/>  ],<br/>  "instance-update": [<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:DescribeDisks",<br/>    "ecs:JoinSecurityGroup",<br/>    "ecs:LeaveSecurityGroup",<br/>    "ecs:AttachKeyPair",<br/>    "ecs:ModifyInstance*",<br/>    "ecs:ReplaceSystemDisk",<br/>    "ecs:ModifyPrepayInstanceSpec",<br/>    "ecs:StopInstance",<br/>    "ecs:StartInstance",<br/>    "ecs:AllocatePublicIpAddress",<br/>    "ecs:DescribeInstances",<br/>    "ecs:DescribeUserData",<br/>    "ecs:DescribeInstanceRamRole",<br/>    "ecs:DescribeInstanceAutoRenewAttribute"<br/>  ],<br/>  "oss-bucket-all": [<br/>    "oss:*Bucket*"<br/>  ],<br/>  "oss-bucket-create": [<br/>    "oss:ListBuckets",<br/>    "oss:CreateBucket",<br/>    "oss:SetBucketACL",<br/>    "oss:*BucketCORS",<br/>    "oss:*BucketWebsite",<br/>    "oss:*BucketLogging",<br/>    "oss:*BucketReferer",<br/>    "oss:*BucketLifecycle",<br/>    "oss:*BucketEncryption",<br/>    "oss:*BucketTagging",<br/>    "oss:SetBucketVersioning",<br/>    "oss:GetBucketInfo"<br/>  ],<br/>  "oss-bucket-delete": [<br/>    "oss:ListBuckets",<br/>    "oss:DeleteBucket",<br/>    "oss:GetBucketInfo"<br/>  ],<br/>  "oss-bucket-read": [<br/>    "oss:GetBucket*"<br/>  ],<br/>  "oss-bucket-update": [<br/>    "oss:SetBucketACL",<br/>    "oss:*BucketCORS",<br/>    "oss:*BucketWebsite",<br/>    "oss:*BucketLogging",<br/>    "oss:*BucketReferer",<br/>    "oss:*BucketLifecycle",<br/>    "oss:*BucketEncryption",<br/>    "oss:*BucketTagging",<br/>    "oss:SetBucketVersioning",<br/>    "oss:GetBucketInfo"<br/>  ],<br/>  "security-group-all": [<br/>    "ecs:*SecurityGroup*",<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources"<br/>  ],<br/>  "security-group-create": [<br/>    "ecs:CreateSecurityGroup",<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:ModifySecurityGroupPolicy",<br/>    "ecs:Describe*"<br/>  ],<br/>  "security-group-delete": [<br/>    "ecs:DeleteSecurityGroup",<br/>    "ecs:DescribeSecurityGroupAttribute"<br/>  ],<br/>  "security-group-read": [<br/>    "ecs:DescribeSecurityGroupAttribute",<br/>    "ecs:DescribeSecurityGroups",<br/>    "ecs:DescribeTags"<br/>  ],<br/>  "security-group-rule-all": [<br/>    "ecs:AuthorizeSecurityGroup*",<br/>    "ecs:ModifySecurityGroupRule",<br/>    "ecs:ModifySecurityGroupEgressRule",<br/>    "ecs:RevokeSecurityGroup*",<br/>    "ecs:DescribeSecurityGroupAttribute"<br/>  ],<br/>  "security-group-rule-create": [<br/>    "ecs:AuthorizeSecurityGroup*",<br/>    "ecs:DescribeSecurityGroupAttribute"<br/>  ],<br/>  "security-group-rule-delete": [<br/>    "ecs:RevokeSecurityGroup*",<br/>    "ecs:DescribeSecurityGroupAttribute"<br/>  ],<br/>  "security-group-rule-read": [<br/>    "ecs:DescribeSecurityGroupAttribute"<br/>  ],<br/>  "security-group-rule-update": [<br/>    "ecs:ModifySecurityGroupRule",<br/>    "ecs:ModifySecurityGroupEgressRule",<br/>    "ecs:DescribeSecurityGroupAttribute"<br/>  ],<br/>  "security-group-update": [<br/>    "ecs:UntagResources",<br/>    "ecs:TagResources",<br/>    "ecs:ModifySecurityGroupPolicy",<br/>    "ecs:Describe*"<br/>  ],<br/>  "slb-all": [<br/>    "slb:*LoadBalancer*",<br/>    "slb:UntagResources",<br/>    "slb:TagResources",<br/>    "slb:ListTagResources"<br/>  ],<br/>  "slb-create": [<br/>    "slb:CreateLoadBalancer",<br/>    "slb:UntagResources",<br/>    "slb:TagResources",<br/>    "slb:DescribeLoadBalancerAttribute",<br/>    "slb:ListTagResources"<br/>  ],<br/>  "slb-delete": [<br/>    "slb:DeleteLoadBalancer",<br/>    "slb:DescribeLoadBalancerAttribute"<br/>  ],<br/>  "slb-read": [<br/>    "slb:DescribeLoadBalancerAttribute",<br/>    "slb:ListTagResources"<br/>  ],<br/>  "slb-update": [<br/>    "slb:UntagResources",<br/>    "slb:TagResources",<br/>    "slb:SetLoadBalancer*",<br/>    "slb:ModifyLoadBalancer*",<br/>    "slb:DescribeLoadBalancerAttribute",<br/>    "slb:ListTagResources"<br/>  ],<br/>  "vpc-all": [<br/>    "vpc:*Vpc*",<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ListTagResources",<br/>    "vpc:DescribeVpcAttribute",<br/>    "vpc:DescribeRouteTables"<br/>  ],<br/>  "vpc-create": [<br/>    "vpc:CreateVpc",<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ModifyVpcAttribute",<br/>    "vpc:DescribeVpcAttribute",<br/>    "vpc:ListTagResources",<br/>    "vpc:DescribeRouteTables"<br/>  ],<br/>  "vpc-delete": [<br/>    "vpc:DeleteVpc",<br/>    "vpc:DescribeVpcAttribute"<br/>  ],<br/>  "vpc-read": [<br/>    "vpc:DescribeVpcAttribute",<br/>    "vpc:ListTagResources",<br/>    "vpc:DescribeRouteTables"<br/>  ],<br/>  "vpc-update": [<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ModifyVpcAttribute",<br/>    "vpc:DescribeVpcAttribute",<br/>    "vpc:ListTagResources",<br/>    "vpc:DescribeRouteTables"<br/>  ],<br/>  "vswitch-create": [<br/>    "vpc:CreateVSwitch",<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:DescribeVSwitchAttributes",<br/>    "vpc:ListTagResources"<br/>  ],<br/>  "vswitch-delete": [<br/>    "vpc:DeleteVSwitch",<br/>    "vpc:DescribeVSwitchAttributes"<br/>  ],<br/>  "vswitch-read": [<br/>    "vpc:DescribeVSwitchAttributes",<br/>    "vpc:ListTagResources"<br/>  ],<br/>  "vswitch-update": [<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ModifyVSwitchAttribute",<br/>    "vpc:DescribeVSwitchAttributes",<br/>    "vpc:ListTagResources"<br/>  ],<br/>  "vswithch-all": [<br/>    "vpc:*VSwitch*",<br/>    "vpc:UntagResources",<br/>    "vpc:TagResources",<br/>    "vpc:ListTagResources"<br/>  ]<br/>}</pre> | no |
| <a name="input_policies"></a> [policies](#input\_policies) | (Deprecated, use alicloud\_ram\_policy\_document data source instead) List Map of known policy actions. Each item can include the following field: `name`(the policy name prefix, default to a name with 'terraform-ram-policy-' prefix), `actions`(list of the custom actions used to create a ram policy), `defined_actions`(list of the defined actions used to create a ram policy), `resources`(list of the resources used to create a ram policy, default to [*]), `effect`(Allow or Deny, default to Allow), `force`(whether to delete ram policy forcibly, default to true). | `list(map(string))` | `[]` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | (Deprecated from version 1.1.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD\_PROFILE environment variable. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | (Deprecated from version 1.1.0) The region used to launch this module resources. | `string` | `""` | no |
| <a name="input_shared_credentials_file"></a> [shared\_credentials\_file](#input\_shared\_credentials\_file) | (Deprecated from version 1.1.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used. | `string` | `""` | no |
| <a name="input_skip_region_validation"></a> [skip\_region\_validation](#input\_skip\_region\_validation) | (Deprecated from version 1.1.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet). | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_id"></a> [policy\_id](#output\_policy\_id) | Id of the custom policy |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | Name of the custom policy |
| <a name="output_this_policy_id"></a> [this\_policy\_id](#output\_this\_policy\_id) | (Deprecated, use 'policy\_id') Id of the custom policy |
| <a name="output_this_policy_name"></a> [this\_policy\_name](#output\_this\_policy\_name) | (Deprecated, use 'policy\_name') Name of the custom policy |
<!-- END_TF_DOCS -->

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

