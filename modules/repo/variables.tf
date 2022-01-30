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

variable "copyright" {
  description = "Information about the copyright notice to include in the LICENSE file"
  type = object({
    since   = string,
    holders = optional(list(string))
  })
  nullable = false
}

locals {
  copyright = defaults(var.copyright, {})
}
