// state the providers and versions used in the project
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.18.0"
    }
  }
}

// configure the terraform backend to use a workspace in terraform cloud
/* terraform {
  backend "remote" {
    organization = "feras-tamimi"

    workspaces {
      name = "terraform-cluster"
    }
  }
} */

// configure the providers
// the google cloud credential is storeed as the environment variable GOOGLE_CREDENTIAL in the terraform workspace
provider "google" {
  project = var.project_id
  region = var.region
  zone = var.zone
}
