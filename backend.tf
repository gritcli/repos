terraform {
  cloud {
    organization = "gritcli"

    workspaces {
      name = "repos"
    }
  }
}
