<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Results/Handlers

## Purpose
One handler per result kind, discovered by `ResultDispatcher` automatically. Each handler performs one
reward/effect inside the executor actor.

## Key Files

| File | Description |
|------|-------------|
| `ResAddHealthHandler.cs` / `ResAddManaHandler.cs` | Restore health/mana |
| `ResAddSpellHandler.cs` / `ResLearnSpellHandler.cs` / `ResGiveSpellHandler.cs` | Grant or teach spells |
| `ResDropTableHandler.cs` | Roll and grant a drop table (calls `Game/DropTables`) |
| `ResSpawnHandler.cs` | Spawn an object/creature in the zone |
| `ResTeleportHandler.cs` | Zone teleport |
| `ResDrawHandHandler.cs` | Draw a combat hand |
| `ResControlMusicHandler.cs` / `ResPlaySoundHandler.cs` | Zone audio control |
| `ResActorDialogHandler.cs` | NPC dialog lines |
| `ResDisplayTextHandler.cs` | Display text to the client |
| `ResDynamodHandler.cs` | Apply dynamic mod adjustments |
| `ResInitiateCombatHandler.cs` | Start a duel against the player |
| `ResPostEventHandler.cs` | Side-band event posting (scores, tracking) |

## For AI Agents

### Working In This Directory
- Naming is `Res<Kind>Handler`; match it.
- Handlers are effects: mutate the player/world, reply to `replyTo`, never branch into other result kinds themselves.
- When a handler needs zone or quest specifics, use the context types in `../Contexts/` rather than re-resolving.

### Testing Requirements
No unit tests. Drive the owning quest/trigger in a client and confirm the effect and the reply ordering.

## Dependencies

### Internal
`BaseResultHandler`, `DropTables`, `Services` (inventory, spellbook entry points), `Shared/Behaviors`.

### External
Akka.NET, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
