# GitHub Actions

## set-pr-label
A GitHub action to automatically set label to the pull request.

```
workflow "on pull request create, set label" {
  on = "pull_request"
  resolves = ["filter-branch", "set-label"]
}

action "filter-branch" {
  uses = "actions/bin/filter@master"
  args = "branch frontend/*"
}

action "Set label" {
  needs = ["filter-branch"]
  uses = "fujikky/actions/set-pr-label@master"
  args = "frontend"
  secrets = ["GITHUB_TOKEN"]
}
```

