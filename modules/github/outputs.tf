output "org" {
  description = "The GitHub organization."
  value       = "gritcli"
}

output "app" {
  description = "The GitHub app used to perform GitHub API operations."
  value = {
    id              = "168361"
    installation_id = "22772285"
  }
}

output "commit_author" {
  description = "The Git commit author."
  value = {
    name  = "grit-automation[bot]"
    email = "98673121+grit-automation[bot]@users.noreply.github.com"
  }
}
