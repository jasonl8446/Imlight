<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Imlight.Director

## Purpose
The executable entry point. Boots the whole server in a fixed order: configuration, Akka actor system,
patch server (before any resource, so missing resources can be downloaded), resource discovery, login
server, N game servers (one per realm), RavenDB store, then idles with periodic heartbeat logs.

## Key Files

| File | Description |
|------|-------------|
| `Program.cs` | `Main`. Reads every setting from `Config/Imlight.ini`, creates the Akka system (`"Imlight"`), runs the boot sequence, tracks the KALI major version label |
| `AkkaConfiguration.cs` | Loads `Config/akka.conf` from the assembly location and creates the actor system |
| `ResourceContainer.cs` | Reflection-based discovery: instantiates and initializes every `RootSingleResourceSingleton<>` / `RootDirectoryResourceSingleton<>` derivation in CoreLib, no manual registration |
| `ManifestGenerator.cs` | Writes patch manifests (`go`, `item`, `spell`, `npc`, `shopkeeper`, `creature`, `deck`) into `/manifests/` from WAD contents |
| `Config/Imlight.ini` | The configuration file consumed by `ConfigurationManager` (servers, ports, realms, database, logging) |
| `Config/akka.conf` | Akka.NET actor system configuration |
| `Certificates/base` | TLS certificate material for the store |

## For AI Agents

### Working In This Directory
- Boot order is load-bearing. Changing it (for example starting game servers before resources are loaded) breaks the "patch first" guarantee. Preserve the sequence in `Main`.
- `ResourceContainer` finds resources by base type inheritance: any new resource singleton must derive from one of the two `Root*Singleton<>` base classes to be discovered.
- Config keys come from `Imlight.ini`; when adding a key, update the `ini` and the `ConfigurationManager.Settings[...]` reads together.
- This is the only project that writes manifests and seeds the embedded database admin account (from the `Database.AdminAccount*` settings).

### Testing Requirements
This project is verified by running it: `dotnet run --project src/Imlight.Director`, watching the boot log
(config, Akka, patch, resources, login, game servers, database), then exercising the client. There are no unit tests.

### Common Patterns
- The `// ==== TIDBITS / IMLIGHT CONFIGURATION / ...` section banners in `Main` are the boot checklist; keep them in sync with the steps.
- `Logger.Information` with `Logger.Args(...)` for every boot milestone.

## Dependencies

### Internal
`Imlight.CoreLib` (servers, resources, data), `Imlight.Common` (config, logging).

### External
Akka.NET (actor system), RavenDB (embedded/remote store), .NET 10 runtime.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
