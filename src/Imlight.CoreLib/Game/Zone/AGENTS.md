<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Zone

## Purpose
The zone subsystem: one actor per zone (`Core/Zone`), the entity/component ECS (`Core/`, `Components/`),
and the per-kind supervisors that own entity actors (`Supervisors/`) plus zone loading (`Core/ZoneLoader`).
This is the server's spatial world model.

## Key Files
Directory container; see the Subdirectories table.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `Core/` | `Zone` actor, `ZoneEntity`/`ZonePath`/`ZoneTrigger` entities, the component base and registry, component actor plumbing, `ZoneLoader`, `ZoneDataFileCache` (see `Core/AGENTS.md`) |
| `Components/` | The 30 zone entity components: interaction (vendors, quest stages, shops, trainer, minigame, auction...), combat (creature AI, deck, equipment, duel), behavior (movement, stats, animation, rendering, volumes) (see `Components/AGENTS.md`) |
| `Supervisors/` | The six entity-kind supervisors plus sigils: `ZoneEntitySupervisor`, `ZonePlayerSupervisor`, `ZoneObjectSupervisor`, `ZonePathSupervisor`, `ZoneTriggerSupervisor`, `ZoneVolumeSupervisor`, `ZoneSigilSupervisor` (see `Supervisors/AGENTS.md`) |
| `AprilFools/` | `CreatureList`: test creature data for the April Fools content (test data, not architecture) |

## For AI Agents

### Working In This Directory
- Read `.agents/AGENT.md` section 8 before touching zone code: one actor per entity, components are plain
  objects hosted by the entity actor and run on its thread, `Self` in a component is a `ComponentActorRef`,
  never `Ask` your own entity or a sibling component with `.Result`, `DeleteObject` stops the whole entity.
- Message flow: client -> session service -> zone -> supervisor -> entity actor -> component handler.
- New behavior on an entity = a new component in `Components/` (see that directory's AGENTS.md), not a new entity subclass.

### Testing Requirements
No unit tests. Boot the Director, enter the affected zone with a client, and verify spawn, interaction, and
transfer against the zone content.

## Dependencies

### Internal
`Shared/Networking`, `Shared/Behaviors`, `Shared/Resources`, `WizardData` (zone data, NPC content),
`Game/Combat` (duel components), `Game/Groups`.

### External
Akka.NET, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
