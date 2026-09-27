<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# WizardData/Collections

## Purpose
One accessor class per document type: the read/write paths the rest of the code calls instead of touching
RavenDB directly. Player documents go through these, and world documents expose `Preload*` methods that
`Game/World/GameWorld` calls once at boot.

## Key Files (by concern)

| File | Description |
|------|-------------|
| `WizardCollection.cs` | The player character: load, save, stats, inventory linkage |
| `AccountCollection.cs` | Accounts, credentials, admin operations |
| `RelationshipCollection.cs` | Buddies/friendships |
| `QuestInstanceCollection.cs` | Per-player quest state (offer/progress/turn-in) |
| `WizardItemCollection.cs` / `WizardReagentCollection.cs` / `WizardPetSnackCollection.cs` | Owned items, reagents, pet snacks |
| `DynamodCollection.cs` | Dynamic modifier state |
| `ClientKeyCollection.cs` | Client key material |
| `OnlinePlayerCollection.cs` | Online player tracking |
| `ChatLogCollection.cs` / `CommandLogCollection.cs` | Chat and command audit logs |
| `InfractionCollection.cs` | Player infractions/punishments |
| `AuctionHouseCollection.cs` | Auction house state |
| `ScoreTrackingCollection.cs` | Score/tracking data |
| `DungeonQuestIndex.cs` | Dungeon quest index lookups |
| `CreatureSpellbookCollection.cs` / `NpcInventoryCollection.cs` / `NpcSpellInventoryCollection.cs` / `NpcDropTableCollection.cs` / `NpcTreasureCardInventoryCollection.cs` | World content accessors with `Preload*` (backed by SpiralDB) |
| `DropTableCollection.cs` | Drop table lookups |
| `GlobalRegistryCollection.cs` | Global registry lookups |
| `ZoneDataCollection.cs` | Zone data access |

## For AI Agents

### Working In This Directory
- Every accessor goes through the shared `Store` (from `PlayerDatabase.Instance`); never open a second document store.
- World-content collections (the `Preload*` ones) are read-mostly and are warmed at boot by `GameWorld`; adding one means adding its `Preload*` and its call in `GameWorld`'s constructor.
- Optimistic concurrency is on for the store (see `RavenDatabaseSingleton`); expect `ConflictException` on concurrent writes and retry, not swallow.

### Testing Requirements
No unit tests. Verify the affected feature with a client; for data-shape checks, inspect the embedded
database files (stop the Director first, then `backup-db.sh` or browse `bin/.../ImlightEmbeddedDatabase`).

## Dependencies

### Internal
`WizardData` (store, models), `Imlight.Common`.

### External
RavenDB client, Newtonsoft.Json.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
