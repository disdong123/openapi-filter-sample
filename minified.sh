# jira
# Dashboards, Groups, Issues, Projects, Workflows, Users
openapi-filter --checkTags \
  --flags "Announcement banner" \
  "Screen tabs" \
  "Screens" \
  "Screen tab fields" \
  "Screen schemes" \
  "Service Registry" \
  "UI modifications (apps)" \
  "Announcement banner" \
  "App data policies" \
  "App migration" \
  "Audit records" \
  "Avatars" \
  "Classification levels" \
  "Dynamic modules" \
  "License metrics" \
  "Plans" \
  "Priority schemes" \
  "App properties" \
  "Application roles" \
  "usernavproperties" \
  "Teams in plan" \
  "Time tracking" \
  "Filter sharing" \
  "Filters" \
  "Issue bulk operations" \
  -- original/jira-latest.json original/jira-latest-filtered.json

# gitlab
# projects, groups
openapi-filter --checkTags \
  --flags award_emoji \
  badges \
  group_avatar \
  invitations \
  wikis \
  alert_management \
  secure_files \
  cargo_packages \
  pages \
  pages_domains \
  project_avatar \
  remote_mirrors \
  batched_background_migrations \
  migrations \
  broadcast_messages \
  avatar \
  bulk_imports \
  keys \
  markdown \
  namespaces \
  organizations \
  snippets \
  usage_data \
  metrics \
  application \
  import \
  slack \
  topics \
  web_commits \
  access_requests \
  ci_lint \
  ci_resource_groups \
  ci_variables \
  cluster_agents \
  clusters \
  composer_packages \
  conan_packages \
  container_registry_event \
  debian_distribution \
  debian_packages \
  dependency_proxy \
  dora_metrics \
  environments \
  error_tracking_client_keys \
  error_tracking_project_settings \
  feature_flags_user_lists \
  feature_flags \
  features \
  freeze_periods \
  generic_packages \
  geo \
  geo_nodes \
  go_proxy \
  group_export \
  group_import \
  group_packages \
  helm_packages \
  integrations \
  issue_links \
  jira_connect_subscriptions \
  maven_packages \
  metadata \
  ml_model_registry \
  npm_packages \
  nuget_packages \
  package_files \
  plan_limits \
  project_export \
  project_hooks \
  project_import \
  project_import_bitbucket \
  project_import_github \
  protected environments \
  pypi_packages \
  release_links \
  resource_milestone_events \
  rpm_packages \
  rubygem_packages \
  suggestions \
  system_hooks \
  terraform_state \
  terraform_registry \
  unleash_api \
  -- original/gitlab-latest.json original/gitlab-latest-filtered.json

redocly bundle original/jira-latest-filtered.json --remove-unused-components -o original/jira-latest-filtered-redocly.json
redocly bundle original/gitlab-latest-filtered.json --remove-unused-components -o original/gitlab-latest-filtered-redocly.json

bash clean.sh original/jira-latest-filtered-redocly.json original/jira-latest-cleaned.json
bash clean.sh original/gitlab-latest-filtered-redocly.json original/gitlab-latest-cleaned.json

bash pages.sh