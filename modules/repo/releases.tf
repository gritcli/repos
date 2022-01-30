resource "github_repository_file" "publish_release_workflow_config" {
  count = local.publish_releases ? 1 : 0

  repository          = github_repository.this.name
  branch              = github_repository.this.default_branch
  file                = ".github/workflows/publish-release.yml"
  overwrite_on_create = true
  commit_author       = module.github.commit_author.name
  commit_email        = module.github.commit_author.email
  commit_message      = "Regenerate workflow configuration from template."

  content = templatefile(
    "${path.module}/templates/workflow-publish-release.yml.tftpl",
    {
      org = module.github.org
    }
  )
}
