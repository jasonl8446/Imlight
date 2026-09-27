<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# WizardData/Implementations

## Purpose
The store plumbing: the embedded RavenDB manager (spooled up when no remote URL is configured) and the
client type provider contract.

## Key Files

| File | Description |
|------|-------------|
| `EmbeddedDatabaseManager.cs` | Spools up the embedded RavenDB instance and seeds the admin account from `Database.AdminAccount*` (called during Director boot when the store is embedded) |
| `IClientTypeProvider.cs` | Contract for client-side type providers used by the data layer |

## For AI Agents

### Working In This Directory
- The embedded manager must stay idempotent (boot runs it once; admin seeding must be safe to repeat).
- If you add store-level behavior, prefer the `RavenDatabaseSingleton` base (parent directory) so remote
  and embedded stores inherit it both.

### Testing Requirements
No unit tests. Boot the Director with an empty `Database.PlayerDatabaseUrl` and confirm the embedded
instance and admin account exist (admin login via the client or a command).

## Dependencies

### Internal
`WizardData` base, `Imlight.Common`, `PlayerDatabase` (consumer).

### External
RavenDB client (and embedded server).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
