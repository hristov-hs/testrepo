# Create ECR for storing the image
module "infra_image_ecr" {
  source = "../../../../../../modules/ecr/v1.0"

  repository_name = var.infra_ecr.name
  codebuild_role_name = var.infra_ecr.role_name
  mutability = var.infra_ecr.mutability
  scan_enabled = var.infra_ecr.scan_enabled
}

# Create CodeBuild to create and push the image
module "base_amazonlinux_dockerbuild" {
  source = "../../../../../../modules/image_builder/v1.0"
  cb_name = local.cb_name_base

  cb_build_image = local.cb_build_base_image
  ecr_repository_uri = module.infra_image_ecr.repository_url
  codebuild_role_arn = local.codebuild_role_arn
  image_os_type = var.base.buildspec.image_os_type
  git_repo_branch = var.base.git.repo_branch
  git_repo_name = var.base.git.repo_name
  git_repo_owner = var.base.git.repo_name

  component = var.component
  environment = var.environment
  ou = var.ou
}
