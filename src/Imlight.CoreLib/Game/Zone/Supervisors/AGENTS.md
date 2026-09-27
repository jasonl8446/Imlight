<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Zone/Supervisors

## Purpose
The per-kind supervisors each zone owns: they own the entity actors of one kind (players, objects, paths,
triggers, volumes) plus sigils, start entity loads, and report load results back to the zone.

## Key Files

| File | Description |
|------|-------------|
| `ZoneEntitySupervisor.cs` | Owns all zone entity actors (creatures, NPCs, objects); starts entity loads and reports done |
| `ZonePlayerSupervisor.cs` | Owns player entities in the zone (load, track, unload) |
| `ZoneObjectSupervisor.cs` | Owns placed objects with their own actor state |
| `ZonePathSupervisor.cs` | Owns `ZonePath` entities |
| `ZoneTriggerSupervisor.cs` | Owns `ZoneTrigger` entities |
| `ZoneVolumeSupervisor.cs` | Owns volume (enter/leave) tracking |
| `ZoneSigilSupervisor.cs` | Owns sigil entities (dungeon sigils) |

## For AI Agents

### Working In This Directory
- A supervisor is a container: it owns entity actors, tracks membership, and reports load results to the
  zone with `ReportLoadedWhenEntitiesLoad`. It does not implement game behavior itself; that belongs to the entities and their components.
- Keep the supervision split by kind when adding a new zone object type; a new kind gets a new supervisor and a zone-side reference in `Zone.cs`.
- Everything here is actor-to-actor messaging; no blocking calls.

### Testing Requirements
No unit tests. Load a zone that contains that kind (e.g. a volume or a sigil) in a client and verify the
behaviors that depend on it (enter/leave events, sigil interaction).

## Dependencies

### Internal
`Zone/Core` (Zone, ZoneEntity), `Zone/Components`, `Shared/Networking`.

### External
Akka.NET, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
