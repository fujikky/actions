FROM alpine:latest

LABEL "name"="set-pr-label"
LABEL "maintainer"="Yusuke Fujiki <yusuke@fujikkys.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="Set Pull Request Label"
LABEL "com.github.actions.description"="Set label to the pull request"
LABEL "com.github.actions.icon"="tag"
LABEL "com.github.actions.color"="blue"

RUN	apk add --no-cache \
	bash \
	ca-certificates \
	curl \
	jq

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
