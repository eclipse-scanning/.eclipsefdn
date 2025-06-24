local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('science.scanning', 'eclipse-scanning') {
  settings+: {
    description: "",
    name: "Eclipse Scanning project",
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  _repositories+:: [
    orgs.newRepo('scanning') {
      allow_merge_commit: true,
      allow_update_branch: false,
      code_scanning_default_languages+: [
        "python"
      ],
      code_scanning_default_setup_enabled: true,
      default_branch: "master",
      delete_branch_on_merge: false,
      description: "Scanning is an open source project for moving scientific instruments and writing NeXus (http://www.nexusformat.org/) compliant files. It is designed to be control system neutral, EPICS, TANGO etc. may be used. See https://projects.eclipse.org/proposals/scanning and https://github.com/eclipse/scanning/blob/master/GETTINGSTARTED.pdf",
      has_wiki: false,
      homepage: "",
      web_commit_signoff_required: false,
      webhooks: [
        orgs.newRepoWebhook('https://notify.travis-ci.org') {
          events+: [
            "create",
            "delete",
            "issue_comment",
            "member",
            "public",
            "pull_request",
            "push",
            "repository"
          ],
        },
      ],
      branch_protection_rules: [
        orgs.newBranchProtectionRule('master') {
          is_admin_enforced: true,
          required_approving_review_count: null,
          required_status_checks+: [
            "any:continuous-integration/travis-ci",
          ],
          requires_pull_request: false,
        },
      ],
    },
  ],
} + {
  # snippet added due to 'https://github.com/EclipseFdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}