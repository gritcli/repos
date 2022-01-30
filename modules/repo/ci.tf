locals {
  workflow_content = local.workflow != null ? file(
    "${path.module}/../../.github/workflows/shared-${local.workflow}.yml",
  ) : null

  workflow_ref_content = local.workflow != null ? templatefile(
    "${path.module}/templates/workflow-ci.yml.tftpl",
    {
      org      = module.github.org
      workflow = local.workflow
    }
  ) : null
}

resource "github_repository_file" "workflow_config" {
  count = local.workflow == null ? 0 : 1

  repository          = github_repository.this.name
  branch              = github_repository.this.default_branch
  file                = ".github/workflows/ci.yml"
  overwrite_on_create = true
  commit_author       = module.github.commit_author.name
  commit_email        = module.github.commit_author.email
  commit_message      = "Regenerate workflow configuration from template."
  content             = local.workflow_ref_content
}

resource "github_branch_protection" "default_branch" {
  count = local.enable_branch_protection ? 1 : 0

  repository_id = github_repository.this.node_id
  pattern       = github_repository.this.default_branch

  # Add "required status checks" for each of the jobs in the workflow.
  #
  # Annoyingly, GitHub identifies the jobs by their display name, which is made
  # up of the job name from the workflow file in each repository _AND_ the job
  # name from the shared workflow they refer to.
  #
  # We build the cross-product of these names below by parsing the YAML files.
  required_status_checks {
    strict = true
    contexts = flatten(
      [for key, ref in yamldecode(local.workflow_ref_content).jobs :
        [for key, shared in yamldecode(local.workflow_content).jobs : "${ref.name} / ${shared.name}"]
      ]
    )
  }
}
