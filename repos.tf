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
