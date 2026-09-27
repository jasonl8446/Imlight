<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Shared/Packets

## Purpose
The numbered internal protocol families the server actors speak to each other: one class per protocol
(`SERVER_100_PROTOCOL`, `SERVICE_101_PROTOCOL`, `ZONE_102_PROTOCOL`, ...) implementing `IServerProtocol`,
with nested message classes implementing `IServerMessage`. These are actor-to-actor message carriers and
may hold non-serializable payloads (a raw `Socket` in `MSG_ALLOCATESOCKET` is the canonical example).

## Key Files

| File | Description |
|------|-------------|
| `SERVER_100_PROTOCOL.cs` | Internal server general messages: create game server, allocate/deallocate socket, query actor factory, initialize |
| `SERVICE_101_PROTOCOL.cs` | Service-level messages |
| `ZONE_102_PROTOCOL.cs` | Zone protocol (transfer, move, broadcast) plus the `ZoneBroadcastTarget` bitmask that selects which supervisors receive a broadcast |
| `ACCOUNT_104_PROTOCOL.cs` / `CHARACTER_103_PROTOCOL.cs` | Account and character internal messages |
| `PATCH_105_PROTOCOL.cs` / `PROCESS_107_PROTOCOL.cs` | Patch and process internal messages |
| `LOGIN_108_PROTOCOL.cs` / `GROUP_109_PROTOCOL.cs` | Login and group internal messages |
| `COMBAT_106_PROTOCOL.cs` / `TUTORIAL_PROTOCOL.cs` | Combat and tutorial internal messages |

## For AI Agents

### Working In This Directory
- These are NOT the client wire types. Client-facing protocol types (e.g. `LOGIN_7_PROTOCOL`) are generated
  in `Imcodec.MessageLayer.Generated` and must never be hand-rolled. The two families coexist: `using
  Imlight.CoreLib.Shared.Packets` for internal actor traffic, `using Imcodec.MessageLayer.Generated` for
  client traffic.
- Adding an internal message = add a nested `MSG_*` class with the right `MessageOrder` in the protocol file, then a `[MessageHandler]` method wherever it is consumed.
- Message order numbers within a protocol are the protocol's own sequence; keep them stable per protocol.

### Testing Requirements
No unit tests. Verify the consuming flow (e.g. server creation via `MSG_CREATEGAMESERVER` at boot, zone
broadcasts in-game).

## Dependencies

### Internal
`Shared/Networking` (IServerProtocol/IServerMessage), sibling subsystems that send/receive these messages.

### External
Akka.NET (actor payloads), Imcodec (for types referenced by messages).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
