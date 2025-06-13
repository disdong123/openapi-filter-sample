# jira
# Dashboards, Groups, Issues, Projects, Workflows,  Users
openapi-filter --checkTags \
  --flags "Announcement banner" \
  "Filters" \
  "JQL" \
  "Issue comments" \
  "App data policies" \
  "App migration" \
  "App properties" \
  "Application roles" \
  "Audit records" \
  "Avatars" \
  "Classification levels" \
  "Dynamic modules" \
  "Filter sharing" \
  "Group and user picker" \
  "Issue attachments" \
  "Issue bulk operations" \
  "Issue comment properties" \
  "Issue custom field associations" \
  "Issue custom field configuration (apps)" \
  "Issue custom field contexts" \
  "Issue custom field options" \
  "Issue custom field options (apps)" \
  "Issue custom field values (apps)" \
  "Issue field configurations" \
  "Issue fields" \
  "Issue link types" \
  "Issue links" \
  "Issue navigator settings" \
  "Issue notification schemes" \
  "Issue priorities" \
  "Issue properties" \
  "Issue redaction" \
  "Issue remote links" \
  "Issue resolutions" \
  "Issue search" \
  "Issue security level" \
  "Issue security scheme" \
  "Issue security schemes" \
  "Issue type properties" \
  "Issue type schemes" \
  "Issue type screen schemes" \
  "Issue types" \
  "Issue votes" \
  "Issue watchers" \
  "Issue worklog properties" \
  "Issue worklogs" \
  "JQL functions (apps)" \
  "Jira expressions" \
  "Jira settings" \
  "Labels" \
  "License metrics" \
  "Myself" \
  "Permission schemes" \
  "Permissions" \
  "Plans" \
  "Priority schemes" \
  "Project avatars" \
  "Project categories" \
  "Project classification levels" \
  "Project components" \
  "Project email" \
  "Project features" \
  "Project key and name validation" \
  "Project permission schemes" \
  "Project properties" \
  "Project role actors" \
  "Project roles" \
  "Project templates" \
  "Project types" \
  "Project versions" \
  "Screen schemes" \
  "Screen tab fields" \
  "Screen tabs" \
  "Screens" \
  "Server info" \
  "Service Registry" \
  "Status" \
  "Tasks" \
  "Teams in plan" \
  "Time tracking" \
  "UI modifications (apps)" \
  "User properties" \
  "User search" \
  "Workflow scheme drafts" \
  "Workflow scheme project associations" \
  "Workflow schemes" \
  "Workflow status categories" \
  "Workflow statuses" \
  "Workflow transition properties" \
  "Workflow transition rules" \
  "Webhooks" \
  -- original/jira-latest.json original/jira-latest-filtered.json

# gitlab
# projects, groups
openapi-filter --checkTags \
  --flags award_emoji \
  badges \
  runners \
  group_avatar \
  invitations \
  members \
  personal_access_tokens \
  wikis \
  alert_management \
  branches \
  secure_files \
  cargo_packages \
  commits \
  pages \
  pages_domains \
  project_avatar \
  projects_job_token_scope \
  project_snippets \
  protected_tags \
  remote_mirrors \
  tags \
  batched_background_migrations \
  admin \
  migrations \
  broadcast_messages \
  applications \
  avatar \
  bulk_imports \
  job \
  jobs \
  events \
  keys \
  markdown \
  namespaces \
  organizations \
  snippets \
  hooks \
  usage_data \
  metrics \
  user_counts \
  user \
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
  container_registry \
  container_registry_event \
  debian_distribution \
  debian_packages \
  dependency_proxy \
  deploy_keys \
  deploy_tokens \
  deployments \
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
  merge_requests \
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
  project_packages \
  protected environments \
  pypi_packages \
  release_links \
  releases \
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

node minified.js