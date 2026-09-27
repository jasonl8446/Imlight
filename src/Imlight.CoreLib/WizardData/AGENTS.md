<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# WizardData

## Purpose
Both data stores of the project. Player-generated data lives in RavenDB (lazy singleton `Store`, per-type
accessor `Collections`, `Models` document types). Static world content lives in the `SpiralDB` static store,
loaded from the spiraldb repository (or `spiraldb-cache/` when remote is disabled).

## Key Files

| File | Description |
|------|-------------|
| `SpiralDB.cs` | Static in-memory world store: creature spellbooks, drop tables, global registry, NPC inventories/spells/drops/treasure cards, quest templates, zone data. `Load()` once at boot; remote sync (with rollback on failure) controlled by `Database.SpiralDB*` settings |
| `RavenDatabaseSingleton.cs` | Abstract lazy singleton base for RavenDB stores; embedded store when no URL is configured, remote when configured; certificate handling for self-signed dev certs |
| `DatabaseUtilities.cs` | Store/database helper utilities |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `Collections/` | One accessor per document type (25): wizards, accounts, quest instances, chat log, online players, NPC inventories, drop tables, and more (see `Collections/AGENTS.md`) |
| `Databases/` | `PlayerDatabase`: the concrete store with `DatabaseName`/`Url`/`CertificatePath` from config (single file) |
| `Implementations/` | `EmbeddedDatabaseManager` (spools up the embedded RavenDB and seeds the admin account), `IClientTypeProvider` (see `Implementations/AGENTS.md`) |
| `Models/` | Document model types, split by ownership: Player, World, Misc (see `Models/AGENTS.md`) |

## For AI Agents

### Working In This Directory
- Two distinct stores, do not mix: mutable player state -> RavenDB via `Collections`; immutable world content -> `SpiralDB` static lookups. A "missing data" bug is usually missing content in `spiraldb-cache/`, not missing code here.
- Accessor naming: `XxxCollection` for player documents, `XxxCollection` with `Preload*` methods for world documents loaded at boot (called from `GameWorld`'s constructor).
- Document models are serialized with Newtonsoft.Json; adding a field is additive, renaming is a migration problem (check `spiraldb-reference.md` in `docs/` for content conventions).

### Testing Requirements
No unit tests. Verify by booting the Director (store init, embedded database admin seeding) and exercising
the feature through the client. Use `backup-db.sh` before destructive experiments (Director stopped).

## Dependencies

### Internal
`Imlight.Common` (config); consumed by `Auth`, `Game`, `Login`, `Director`.

### External
RavenDB client (and embedded server), Newtonsoft.Json.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
