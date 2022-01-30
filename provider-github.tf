module "github" {
  source = "./modules/github"
}

provider "github" {
  owner = module.github.org

  app_auth {
    id              = module.github.app.id
    installation_id = module.github.app.installation_id
  }
}
