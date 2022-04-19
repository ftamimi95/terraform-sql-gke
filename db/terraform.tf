terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.18.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">=4.18.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

provider "google" {
  project = var.project_id
  region = var.region
}

