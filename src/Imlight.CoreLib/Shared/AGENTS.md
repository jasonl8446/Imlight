<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Shared

## Purpose
The cross-server infrastructure used by login, patch, and game alike: the actor/session/socket networking
core, internal protocol message definitions, client-behavior mirrors, WAD/resource loading, character
helpers, crypto, and small shared structures.

## Key Files
This directory contains only subdirectories plus the csproj-free layout (see the Subdirectories table).

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `Networking/` | The load-bearing core: `Server`, `SessionActor`, `ServiceFactory`, `MessageService`, `ReceiveProtocolDispatcher` (attribute-based dispatch), socket listeners/senders, mailboxes, token bucket (see `Networking/AGENTS.md`) |
| `Packets/` | Numbered internal protocol definitions (`SERVER_100_PROTOCOL`, `ZONE_102_PROTOCOL`, ...) implementing `IServerProtocol`/`IServerMessage`; actor-to-actor message carriers, not the client wire types (see `Packets/AGENTS.md`) |
| `Behaviors/` | `Server*Behavior` classes mirroring the client's own behavior objects (inventory, spellbook, quest, friends, mounts, ...) (see `Behaviors/AGENTS.md`) |
| `Resources/` | WAD cache, core object factory, resource singletons and discovery bases used by `ResourceContainer` (see `Resources/AGENTS.md`) |
| `Cryptography/` | Pass/session keys, client key exchange, CRC (see `Cryptography/AGENTS.md`) |
| `Character/` | Character helpers, buddy stats builder/CRC, magic level config (see `Character/AGENTS.md`) |
| `Items/` | Item helpers, dye mapping, price modifiers (see `Items/AGENTS.md`) |
| `Services/` | Base cross-server services (`AccountService`, `ControlService`) available on every server (see `Services/AGENTS.md`) |
| `Structures/` | Small generic data structures (cache, list queue, observable set) (see `Structures/AGENTS.md`) |
| `Utilities/` | Data manipulation helpers and `RandomGen` (see `Utilities/AGENTS.md`) |

## For AI Agents

### Working In This Directory
- This is the most depended-on area: prefer changing call sites over touching `Networking/`, and if you must change the dispatch or session model, expect impact across all three servers.
- Two kinds of "protocol" coexist: `Packets/` (internal server actors, may carry non-serializable payloads like sockets) and Imcodec-generated client wire types (`Imcodec.MessageLayer.Generated.Login_7_Protocol` etc.). Never hand-roll a wire struct.
- Resource loading goes through the `Root*Singleton` bases in `Resources/`, because the Director's `ResourceContainer` discovers them by reflection.

### Testing Requirements
No unit tests. Boot the Director and exercise whichever server you touched.

## Dependencies

### Internal
`Imlight.Common`; `WizardData` for behavior defaults and character models.

### External
Akka.NET, Imcodec (IO, types, crypto, WAD).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
