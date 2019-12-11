output "stage" {
  value = "infra_image_factory_base-amazonlinux"
}

output "infra_image_ecr_url" {
  value = module.infra_image_ecr.repository_url
}

output "infa_image_ecr_id" {
  value = module.infra_image_ecr.registry_id
}

output "base_codebuild_project_name" {
  value = module.base_amazonlinux_dockerbuild.codebuild_project_name
}
