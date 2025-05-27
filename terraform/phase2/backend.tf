terraform {
  backend "remote" {
    organization = "letsencrypt-org"

    workspaces {
      name = "letsencrypt-phase2"
    }
  }
}

