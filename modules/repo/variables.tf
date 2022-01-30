variable "name" {
  description = "The repository name"
  type        = string
  nullable    = false
}

variable "description" {
  description = "The repository description"
  type        = string
  nullable    = false
}

variable "license" {
  description = "The type of LICENSE to publish"
  type        = string
  nullable    = false
  default     = "mit"
}

variable "private" {
  description = "Indicates whether the repository is hidden from the public"
  type        = bool
  default     = false
  nullable    = false
}

variable "languages" {
  description = "The languages used within the repository"
  type        = list(string)
  nullable    = false
}

variable "workflow" {
  description = "Override the GitHub Actions workflow, otherwise it is determined based on the specified language"
  type        = string
  default     = "(default)" # sentinel used to detect absence of attribute
  nullable    = true
}

variable "copyright" {
  description = "Information about the copyright notice to include in the LICENSE file"
  type = object({
    since   = string,
    holders = optional(list(string))
  })
  nullable = false
}

variable "publish_releases" {
  description = "Automatically publish GitHub releases when a tag is pushed."
  type        = bool
  default     = null # sentinel used to detect absence of attribute
}

locals {
  primary_language = length(var.languages) == 0 ? null : var.languages[0]
  workflow         = var.workflow == "(default)" ? local.primary_language : var.workflow

  enable_branch_protection     = local.workflow != null && !var.private # not supported by private repos on free-tier
  enable_dependabot            = local.primary_language != null
  enable_dependabot_auto_merge = local.enable_dependabot && github_repository.this.allow_auto_merge

  copyright = defaults(var.copyright, {})

  publish_releases = var.publish_releases == null ? local.workflow != null : var.publish_releases # by default, publish if there are other workflows
}
