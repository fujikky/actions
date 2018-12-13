# GitHub Actions

A GitHub action to automatically set label to the pull request.

```
workflow "on pull request create, set label" {
  on = "pull_request"
  resolves = ["Filter frontend branch"]
}

action "Filter frontend branch" {
  uses = "actions/bin/filter@master"
  args = "branch frontend/*"
}

action "Set label" {
  needs = ["Filter frontend branch"]
  uses = "fujikky/actions/set-pr-label@master"
  arg = "bug"
  secrets = ["GITHUB_TOKEN"]
}
```

