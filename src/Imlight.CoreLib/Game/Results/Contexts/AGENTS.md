<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Results/Contexts

## Purpose
The data a result handler may act on, scoped per execution site (quest completion, zone trigger, generic).

## Key Files

| File | Description |
|------|-------------|
| `GenericResultContext.cs` | Base context: filtered results, player ref/object, reply actor, optional zone/quest/goal/trigger names |
| `QuestResultContext.cs` | Adds quest-specific state for turn-in style results |
| `ZoneResultContext.cs` | Adds zone-specific state for zone trigger results |

## For AI Agents

### Working In This Directory
- The context is built once per execution by `ResultDispatcher` and handed to the executor actor; handlers must not rebuild it.
- Prefer the narrowest context that fits; `replyTo` is how handlers report completion back to the caller.

### Testing Requirements
No unit tests. Verify through the feature that executes the results (quest turn-in, zone trigger) in a client.

## Dependencies

### Internal
`IResultContext`, `Requirements` context types, `WizardData`.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
