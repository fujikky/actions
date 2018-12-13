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

URI=https://api.github.com
API_VERSION=v3
API_HEADER="Accept: application/vnd.github.${API_VERSION}+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

main() {
    label="$1"
    action=$(jq --raw-output .action "$GITHUB_EVENT_PATH")
    owner=$(jq --raw-output .pull_request.head.repo.owner.login "$GITHUB_EVENT_PATH")
    repo=$(jq --raw-output .pull_request.head.repo.name "$GITHUB_EVENT_PATH")
    number=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")

    echo "DEBUG -> action: $action owner: $owner repo: $repo number: $number"

    if [[ "$action" == "opened" ]]; then
        result=$(
            curl -XPOST -sSL \
                -H "${AUTH_HEADER}" \
                -H "${API_HEADER}" \
                -H "Content-Type: application/json" \
                -d "{\"labels\":[\"${label}\"]}" \
                "${URI}/repos/${owner}/${repo}/issues/${number}/labels"
        )

        echo $result
    fi
}

main "$@"