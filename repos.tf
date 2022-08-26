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

module "repo_homebrew_action" {
  source      = "./modules/repo"
  name        = "homebrew-action"
  description = "A GitHub action for publishing Homebrew formulae to private taps."
  languages   = ["go"]

  copyright = {
    since = 2022
  }
}
