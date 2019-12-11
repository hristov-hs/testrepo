# Module infra_image_ecr
variable "infra_ecr" {
  default = {
    name          = "base_amazonlinux"
    mutability    = "IMMUTABLE"
    scan_enabled  = true
    role_name     = "InfrastructureCodeBuildCustomServiceRole"

  }
}

# Module base_amazonlinux_dockerbuild
variable "base" {
  type = map(map(string))
  default = {
    codebuild = {
      name                = ""
      codebuild_role_name = "InfrastructureCodeBuildCustomServiceRole"
      sfx                 = "cb-base"
    }
    buildspec = {
      image_os_type       = "amazonlinux"
    }
    git = {
      repo_branch = "master"
      repo_name   = "hs_aws_applications_infra"
      repo_owner  = "hedgeserv"
    }
  }
}
