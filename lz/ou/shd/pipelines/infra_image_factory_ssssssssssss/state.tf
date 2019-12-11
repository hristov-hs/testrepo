terraform {
  backend "s3" {
    bucket = "hedgeserv-shd-lz-us-east-2-s3-state"
    key    = "lz/ou/core/shd/pipelines/infra_image_factory/terraform.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "accounts_bootstrap" {
  backend = "s3"
  config = {
    bucket = "hedgeserv-shd-lz-us-east-2-s3-state"
    key    = "lz/ou/core/shd/pipelines/accounts_bootstrap/terraform.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "org_prerequizites" {
  backend = "s3"
  config = {
    bucket = "hedgeserv-org-tf-us-east-2-s3-state"
    key    = "lz/ou/core/org/prerequisites/terraform.tfstate"
    region = "us-east-2"
  }
}

data "terraform_remote_state" "infra_image_factory-light" {
  backend = "s3"
  config = {
    bucket = "hedgeserv-shd-lz-us-east-2-s3-state"
    key    = "lz/ou/core/shd/pipelines/infra_image_factory-light/terraform.tfstate"
    region = "us-east-2"
  }
}
