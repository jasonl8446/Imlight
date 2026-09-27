<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Zone/Core

## Purpose
The zone actor and the entity/component core: `Zone` (one actor per zone), `ZoneEntity` (one actor per
entity, hosting its components), the component base class and registry, the component actor plumbing,
entities `ZonePath` and `ZoneTrigger`, the combat minion variant, and zone loading with a data file cache.

## Key Files

| File | Description |
|------|-------------|
| `Zone.cs` | The zone actor: load with timeout, pending player events/moves during load, mobile ID reservation (5% of the range is reserved, `ReserveMobileId`), player count, critical object tracking, supervisor fan-in load results |
| `ZoneEntity.cs` | Base entity (an actor): template + `CoreObject` host, component dictionary with ordered iteration, `GetComponentOfType`, `GetClientObject` (builds the `MSG_NEWOBJECT` object in the entity's own class), `IClientBehaviorProvider` |
| `ZoneEntityComponent.cs` | Base class for all components: lifecycle hooks, handler hosting on the entity thread |
| `ZoneEntityComponentRegistry.cs` | Resolves component types for an entity template (the component auto-attachment mechanism) |
| `ComponentActorRef.cs` | The `Self`/`ActorRef` shim that routes actor messages to one component instead of the whole entity |
| `ComponentTimerScheduler.cs` | Per-component `IWithTimers` scheduler; `CancelAll` touches only that component's timers |
| `CombatMinionEntity.cs` | Entity variant for combat-only minions |
| `ZonePath.cs` / `ZoneTrigger.cs` | Zone path and trigger entities (actors) |
| `ZoneLoader.cs` | Loads zone data; deserializes fresh objects per load while raw zone files stay in the cache |
| `ZoneDataFileCache.cs` | Caches each zone's raw data files across loads |

## For AI Agents

### Working In This Directory
- The load path is asynchronous by design: supervisors start entities with `BeginEntityLoad` and the zone
  reports done via `ReportLoadedWhenEntitiesLoad`; nothing blocks on `Ask`.
- `ZoneEntity.GetClientObject()` builds the client-facing object in the entity's own class (`WizClientObjectItem` for item templates) because the client reads that class; an object back in range is re-sent as `MSG_NEWOBJECT` (the client ignores `MSG_ADDOBJECT`).
- Dictionaries keyed by a player's `CoreObject` need `ReferenceEqualityComparer`: generated types are records, hashed by value.
- Component ordering matters: `_componentOrder` preserves attach order and iteration uses it; keep attach/detach in lockstep.
- Mobile IDs: allocate through the zone (`ReserveMobileId`), not with random numbers.

### Testing Requirements
No unit tests. Verify by entering a zone (load path), interacting with an entity (component path), and
transferring out (teardown path) with a client.

## Dependencies

### Internal
`Zone/Components` (attachment), `Zone/Supervisors` (ownership), `Shared/Networking`, `Shared/Packets` (ZONE_102), `Shared/Behaviors`, `Shared/Resources`, `WizardData` (zone data).

### External
Akka.NET, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
