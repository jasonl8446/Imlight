<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Results

## Purpose
The "what happens when they do it" side of the gating pair: executes spiraldb `ResultList` data (reward,
spells, spawn, teleport, music, dialog...) via a per-execution actor. Results carry their own requirements,
filtered by `RequirementDispatcher` before execution.

## Key Files

| File | Description |
|------|-------------|
| `ResultDispatcher.cs` | `ExecuteResults(...)`: filters results by their embedded requirements, builds the context, spawns the executor actor, sends `MSG_EXECUTERESULTS`. 5s wizard query timeout |
| `ResultExecutorActor.cs` | The transient actor that runs one result list to completion and replies to the caller |
| `BaseResultHandler.cs` | Base class all result handlers extend |
| `IResultContext.cs` | Context contract (player, zone, quest, goal, trigger, reply actor) |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `Contexts/` | `GenericResultContext`, `QuestResultContext`, `ZoneResultContext` (see `Contexts/AGENTS.md`) |
| `Handlers/` | One handler per result kind: add health/mana/spell, drop table, spawn, teleport, music, dialog, text, dynamod, control music, initiate combat, post event (see `Handlers/AGENTS.md`) |

## For AI Agents

### Working In This Directory
- Adding a new result kind = add a handler in `Handlers/` extending `BaseResultHandler`; the dispatcher discovers it.
- Every execution runs in its own executor actor: handlers may assume a single owner, but must stay actor-safe (no shared mutable state between executions).
- Results with unmet requirements are silently filtered: a "reward missing" report starts in spiraldb result data and player state, then here.
- `ResPostEventHandler` is the hook for side-band events (scores, tracking); extend it rather than adding ad-hoc side effects to reward handlers.

### Testing Requirements
No unit tests. Complete a quest (or trigger) in a client and confirm each result kind fires once, in order.

## Dependencies

### Internal
`Requirements/` (pre-filtering), `WizardData` (results data, wizard state), `Shared/Networking`.

### External
Akka.NET, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
