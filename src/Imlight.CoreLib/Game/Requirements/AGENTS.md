<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Requirements

## Purpose
The "can the player do this?" gate: evaluates spiraldb `RequirementList` data (AND/OR/NOT logic) against a
context (quest, zone, generic). Used to gate quest offers, zone entry, and interactions.

## Key Files

| File | Description |
|------|-------------|
| `RequirementDispatcher.cs` | Static registry + `EvaluateRequirements(requirements, context)`. Handlers auto-register via reflection in the static constructor; AND/OR groups and NOT inversion are resolved here |
| `BaseRequirementHandler.cs` | Base class all requirement handlers extend |
| `IRequirementContext.cs` | The context contract a handler may query (player, zone, quest...) |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `Contexts/` | `GenericRequirementContext`, `QuestRequirementContext`, `ZoneRequirementContext` (see `Contexts/AGENTS.md`) |
| `Handlers/` | One handler per requirement kind: entry value, global registry, has entry / goal / quest, in-zone, is school, school of focus (see `Handlers/AGENTS.md`) |

## For AI Agents

### Working In This Directory
- Adding a new requirement kind = add a handler in `Handlers/` extending `BaseRequirementHandler`; registration is automatic, the dispatcher table is never hand-edited.
- Require the narrowest context that answers the question: zone checks should not leak into "has quest" evaluations.
- Requirement data is content (spiraldb `QuestTemplates`/`GlobalRegistry`); a gate failing is usually a content or context gap.

### Testing Requirements
No unit tests. Gate a quest or zone through the client with and without the precondition satisfied.

## Dependencies

### Internal
`WizardData` (spiraldb requirement data), `Shared/Networking` (actor refs in contexts).

### External
Imcodec (object property types).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
