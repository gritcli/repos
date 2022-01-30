module "repo_grit" {
  source      = "./modules/repo"
  name        = "grit"
  description = "Manage your local Git clones."
  languages   = ["go"]
  workflow    = "go+github"

  copyright = {
    since = 2017
  }
}

module "repo_interact" {
  source      = "./modules/repo"
  name        = "interact"
  description = "Interactive terminal utilities for asynchronous Go CLIs."
  languages   = ["go"]

  copyright = {
    since = 2022
  }
}
