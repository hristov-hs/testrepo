data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_organizations_organization" "current" {}

// context variables, can be overriden during module implementation
locals {
  org_id     = coalesce(var.org_id, data.aws_organizations_organization.current.id)
  region     = coalesce(var.region, data.aws_region.current.name)
  account_id = coalesce(var.account_id, data.aws_caller_identity.current.account_id)
}

// naming prefix, it is produced from ou, environment, region and module, but can be overriden
//   at module implementatation using naming_prefix
locals {
  naming_prefix_generated = "${var.ou}-${var.environment}-${var.component}-${local.region}"
  naming_prefix           = coalesce(var.naming_prefix, local.naming_prefix_generated)
}

locals {
  cb_name_base           = coalesce(var.base.codebuild.name, "${local.naming_prefix}-${var.base.codebuild.sfx}")
  cb_build_base_image    = "${data.terraform_remote_state.infra_image_factory-light.outputs.ecr_repository_url}:latest"
}

// CodeBuild role
locals {
  codebuild_role_name   = var.base.codebuild.codebuild_role_name
  codebuild_role_arn   = join("/", [join(":", ["arn:aws:iam:", data.aws_caller_identity.current.account_id, "role"]), local.codebuild_role_name])
}

variable "org_id" {
  description = "Organization id"
  default     = ""
}

variable "region" {
  description = "Bucket region"
  default     = ""
}

variable "account_id" {
  description = "Account ID"
  default     = ""
}

variable "ou" {
  description = "Project name or abbreviation"
  default     = "core"
}

variable "environment" {
  description = "Environment name or abbreviation"
  default     = "shd"
}

variable "component" {
  description = "Module name or abbreviation"
  default     = "ci"
}

variable "naming_prefix" {
  description = "The prefix that will be used for all resources created. Default to project_environment_region_module_"
  default     = ""
}

