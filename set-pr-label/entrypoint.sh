#!/bin/bash
set -e
set -o pipefail

if [[ ! -z "$TOKEN" ]]; then
	GITHUB_TOKEN=$TOKEN
fi

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

if [[ -z "$LABEL" ]]; then
	echo "Set the LABEL env variable."
	exit 1
fi

URI=https://api.github.com
API_VERSION=v3
API_HEADER="Accept: application/vnd.github.${API_VERSION}+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

main() {
    action=$(jq --raw-output .action "$GITHUB_EVENT_PATH")

    if [[ "$action" != "closed" ]]; then
        owner=$(jq --raw-output .pull_request.head.repo.owner.login "$GITHUB_EVENT_PATH")
        repo=$(jq --raw-output .pull_request.head.repo.name "$GITHUB_EVENT_PATH")

        curl -XPOST -sSL \
            -H "${AUTH_HEADER}" \
            -H "${API_HEADER}" \
            -H "Content-Type: application/json" \
            -d "{\"labels\":[\"${LABEL}\"]}" \
            "${URI}/repos/${owner}/${repo}/issues/${issue}/labels"
    fi
}

main "$@"