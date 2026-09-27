<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# .github

## Purpose
GitHub surface of the repo: the only CI workflow, issue and PR templates, and dependency bot config.

## Key Files

| File | Description |
|------|-------------|
| `workflows/deploy-docs.yml` | Deploys the VitePress book from `docs/` on the `quality-assurance` mainline |
| `ISSUE_TEMPLATE/bug_report.yaml` | Structured bug report template |
| `pull_request_template.md` | PR template enforcing one-item-one-PR and AI-assistance disclosure |
| `dependabot.yml` | Dependency update configuration |

## For AI Agents

### Working In This Directory
- Any PR an agent opens still must disclose AI assistance and be explained in the submitter's own words (CONTRIBUTING.md).
- The PR template is the contract: one item, one PR, no drive-by reformat; target branch is `quality-assurance`.
- Pushes go only to the user's fork (`origin`); never to `upstream` without explicit instruction.

### Testing Requirements
- The docs workflow is the only CI job in the repo. There is no build or test pipeline here; the build check happens locally (`dotnet build`).

## Dependencies

### Internal
`docs/` (deployed by the workflow), the repo's contribution norms (CONTRIBUTING.md).

### External
GitHub Actions, VitePress build toolchain (inside `docs/`).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
