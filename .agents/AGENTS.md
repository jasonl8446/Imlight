<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# .agents

## Purpose
Home of the repository's agent operating guide. The single file here is the authoritative ruleset for every
agent working in this repo, and every other AGENTS.md defers to it on style, headers, comments, and idioms.

## Key Files

| File | Description |
|------|-------------|
| `AGENT.md` | Verified operating rules: project snapshot, sources of truth, code style (braces, naming, file header template, comment rules), architecture idioms (services, zone components, zone loading, Akka and culture rules), commits, known conflicts, scope discipline |

## For AI Agents

### Working In This Directory
- `AGENT.md` is a rules document verified against the tree, not a tutorial. When the tree changes, re-verify the rule and update the file instead of working around it.
- Claims in the file cite file:line evidence; keep that style when extending it.

### Testing Requirements
None. Pure documentation, no build surface.

### Common Patterns
- Numbered sections (1 through 11); every rule names its source (a file:line, a config key, or observed practice).
- Section 10 lists known conflicts (editorconfig vs tree) that must not be "fixed" by mass reformat.

## Dependencies

### Internal
Leaf document. It references `src/` code by path but imports nothing.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
