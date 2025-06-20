#redocly build-docs minified/argoworkflow-3.5.4.json --output=pages/argoworkflow-3.5.4-dark.html --config redocly-dark.yaml
redocly build-docs original/argocd-2.14.2.json --output=pages/argocd-2.14.2-dark.html --config redocly-dark.yaml
redocly build-docs original/gitlab-latest-cleaned.json --output=pages/gitlab-latest-dark.html --config redocly-dark.yaml
redocly build-docs original/jira-latest-cleaned.json --output=pages/jira-latest-dark.html --config redocly-dark.yaml
redocly build-docs original/grafana-11.4.0.json --output=pages/grafana-11.4.0-dark.html --config redocly-dark.yaml

#redocly build-docs minified/argoworkflow-3.5.4.json --output=pages/argoworkflow-3.5.4-light.html --config redocly-light.yaml
redocly build-docs original/argocd-2.14.2.json --output=pages/argocd-2.14.2-light.html --config redocly-light.yaml
redocly build-docs original/gitlab-latest-cleaned.json --output=pages/gitlab-latest-light.html --config redocly-light.yaml
redocly build-docs original/jira-latest-cleaned.json --output=pages/jira-latest-light.html --config redocly-light.yaml
redocly build-docs original/grafana-11.4.0.json --output=pages/grafana-11.4.0-light.html --config redocly-light.yaml