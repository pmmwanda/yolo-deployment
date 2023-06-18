terraform {
  required_providers {
     google = {
      source = "hashicorp/google"
      version = "4.69.1"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
    github = {
      source  = "integrations/github"
      version = "5.25.1"
    }
  }
}