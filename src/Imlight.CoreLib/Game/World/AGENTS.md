<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# World

## Purpose
World-level coordination on a game server: zone creation, loading, player transfers, instance (dungeon
party) containers, and access-pass-based zone validation.

## Key Files

| File | Description |
|------|-------------|
| `GameWorld.cs` | Actor owning `_publicZones`, `_instanceContainers`, and the transfer queue. Validates destinations via `AccessPassManager`, loads zones through `ZoneLoader` actors (15s timeout), preloads NPC vendor/trainer/spellbook/drop data at construction |
| `InstanceContainer.cs` | One instance (dungeon) container: its zone, its members, private vs shared lifecycle |
| `AccessPassManager.cs` | Zone existence and access gating (what a player may enter) |
| `WorldHubZones.cs` | The hub zone set of the world |
| `WorldVendorLocations.cs` | World-wide vendor placement data |

## For AI Agents

### Working In This Directory
- Raid-scale constant: `HARD_LIMIT_INSTANCE_THRESHHOLD = 12` (raids are 12 players) bounds instance handling; do not raise it casually.
- Zone failure paths return fixed error strings (`ERROR_EnterWorldFailed`, `ERROR_FailedToCreate`) hashed into response codes; the client keys off these, so keep them stable.
- A zone is one actor (`Zone`), and its load is reported back asynchronously; nothing in this path blocks on `Ask().Result`.
- Public zone vs instance: public zones are keyed by zone path, instances by id; a zone that comes back into range is re-sent to clients, culling is zone-local.

### Testing Requirements
No unit tests. Transfer zones and open an instance in a client; confirm load, transfer, and teardown logs in `logs/`.

## Dependencies

### Internal
`Game/Zone/Core` (Zone, ZoneLoader), `Game/Groups` (party membership), `WizardData` (zone data, NPC preloads), `Shared/Networking`.

### External
Akka.NET, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
