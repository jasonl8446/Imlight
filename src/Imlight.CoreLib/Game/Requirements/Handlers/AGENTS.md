<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Requirements/Handlers

## Purpose
One handler per requirement kind. Each implements `BaseRequirementHandler` and is discovered by
`RequirementDispatcher` automatically.

## Key Files

| File | Description |
|------|-------------|
| `ReqEntryValueHandler.cs` | Numeric entry value checks (>=, <=, ==) |
| `ReqGloblaRegistryHandler.cs` | Checks against the spiraldb global registry |
| `ReqHasEntryHandler.cs` / `ReqHasGoalHandler.cs` / `ReqHasQuestHandler.cs` | Owned-entry / completed-goal / completed-quest checks |
| `ReqInZoneHandler.cs` | "Player is in zone X" |
| `ReqIsSchoolHandler.cs` / `ReqSchoolOfFocusHandler.cs` | Magic school and school-of-focus checks |

## For AI Agents

### Working In This Directory
- Naming is `Req<Kind>Handler` (note the historical misspelling `Globla`; do not rename it, the registry keys off the type).
- A handler answers one boolean question from the context; no side effects.

### Testing Requirements
No unit tests. Exercise the owning feature (usually a quest gate) through the client.

## Dependencies

### Internal
`BaseRequirementHandler`, the context interfaces, `WizardData`.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
