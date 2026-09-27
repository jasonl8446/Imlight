<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Imlight.CoreLib

## Purpose
The meat of the server: the login, patch, and game servers, all game subsystems (zones, combat, commands,
quests, groups, effects), the shared networking and resource layer, and both data stores (RavenDB player data,
SpiralDB world data). About 320 `.cs` files.

## Key Files

| File | Description |
|------|-------------|
| `Imlight.CoreLib.csproj` | Project file; references Imlight.Common and the Imcodec submodule projects |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `Auth/` | Login-time authentication: account checks, bans, credential validation, authority (see `Auth/AGENTS.md`) |
| `Game/` | Everything game-side: services, zone ECS, combat, quests/results, commands, groups, world (see `Game/AGENTS.md`) |
| `Login/` | Login server actor, its services, and the game server pool (see `Login/AGENTS.md`) |
| `Patch/` | Patch server: remote file-list fetch and WAD download/patching (see `Patch/AGENTS.md`) |
| `Shared/` | Cross-server infrastructure: networking core, packets, behaviors, resources, crypto (see `Shared/AGENTS.md`) |
| `WizardData/` | Both data stores: RavenDB collections/models and the SpiralDB static world store (see `WizardData/AGENTS.md`) |

## For AI Agents

### Working In This Directory
- Read the subdirectory AGENTS.md for the area you touch first; each one states the local extension pattern (new service, new component, new handler, new collection).
- The repo's architectural idiom is registry/dispatcher: `ReceiveProtocolDispatcher` for actors, `ZoneEntityComponentRegistry` for components, `RequirementDispatcher`/`ResultDispatcher` for rules, `ServiceFactory` subclasses for session services. Match the existing registration mechanism instead of inventing new wiring.
- Adding a player-facing feature typically means: a `Game/Services/XService` registered in `GameServiceFactory.ServiceTypes`. Nothing else wires it up.
- Static world content comes from SpiralDB (`WizardData/SpiralDB.cs`); player data from `WizardData/Collections/*`. Missing behavior that looks like a bug is often missing content, not missing code.

### Testing Requirements
No tests in the solution. Verify by building the solution and booting the Director with a client.

### Common Patterns
- Actors expose `protected static Props(...)` factories and are created with `Akka.Actor.Props`.
- Cross-server coordination speaks `SERVER_100_PROTOCOL.*`; per-client protocol types come from `Imcodec.MessageLayer.Generated`.
- `CultureInfo.InvariantCulture` for numbers, `Ordinal*` for identifiers.

## Dependencies

### Internal
`Imlight.Common` (config, logging), `submodule/Imcodec` (wire types, WAD IO, crypto).

### External
Akka.NET, RavenDB client, Newtonsoft.Json, Nito.*, LiteDB.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
