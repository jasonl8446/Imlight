<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# WizardData/Databases

## Purpose
The concrete RavenDB store for player data.

## Key Files

| File | Description |
|------|-------------|
| `PlayerDatabase.cs` | Concrete `RavenDatabaseSingleton<PlayerDatabase>`: `DatabaseName`, `Url`, `CertificatePath` from the `Database.PlayerDatabase*` settings. `PlayerDatabase.Instance.Store` is the single entry point every collection uses |

## For AI Agents

### Working In This Directory
- This file is intentionally tiny: store configuration only. Behavior lives in the `RavenDatabaseSingleton`
  base and the `Collections`.
- Embedded vs remote is decided by whether `PlayerDatabaseUrl` is empty; the embedded path seeds an admin
  account (Director) and uses `Implementations/EmbeddedDatabaseManager`.

### Testing Requirements
No unit tests. Boot the Director and confirm the store init log line (embedded or remote).

## Dependencies

### Internal
`WizardData` base, `Imlight.Common`.

### External
RavenDB client.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
