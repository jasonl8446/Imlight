<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Shared/Networking

## Purpose
The load-bearing networking core every server is built on: the actor/session/socket stack and the
attribute-based message dispatch that replaces manual routing tables.

## Key Files

| File | Description |
|------|-------------|
| `ReceiveProtocolDispatcher.cs` | The base actor: reflectively builds a `Type -> MethodInfo` table from `[MessageHandler]` attributes at construction and routes every received message through it. `MessageHandlerTable.HandlersOf(...)` caches it; `InternalMessageHandlerAttribute` for non-protocol messages |
| `Server.cs` | Base server actor (name, port, Props factory); `LoginServer`/`GameServer`/`PatchServer` derive |
| `SessionActor.cs` | One actor per client connection: socket pairing, attachment of its services, the active wizard |
| `ServiceFactory.cs` | Declares `ServiceTypes` (a `HashSet<Type>` of `MessageService`s) attached to sessions; each server has one subclass in its own tree |
| `MessageService.cs` | Base of all services: `GetActiveWizard()`, `SendToSocket(...)` |
| `IHandshakeService.cs` / `ServerInterfaces.cs` | Handshake contract and server interfaces |
| `SocketListener.cs` / `SocketSender.cs` | Server and client-side socket actors |
| `TcpListenerActor.cs` | The accepting TCP endpoint |
| `MessageHandlerTable.cs` | The reflection cache backing attribute dispatch |
| `ZonePriorityMailbox.cs` | Priority mailbox for zone traffic |
| `TokenBucket.cs` | Rate limiting |
| `QueueMember.cs` | Queueing state for members |
| `Exceptions.cs` | Networking exception types |

## For AI Agents

### Working In This Directory
- This is the most depended-on code in the repo. Prefer adding a consumer (service/actor) over changing the dispatch or session model; if you must change it, expect cross-server impact and verify all three servers.
- The dispatch rule: tag a method with `[MessageHandler(typeof(PROTOCOL.MSG_X))]` and it is routed; there is no other wiring. The table is built once per type.
- A service handler's `Sender` is the session's current sender; replies go through `SendToSocket`, not a raw `Sender` reference captured earlier.
- `TokenBucket` and `QueueMember` implement the connection queue; do not inline ad-hoc rate limits elsewhere.

### Testing Requirements
No unit tests. Any change must be verified by booting the Director and completing a client session against
at least the login and game servers.

## Dependencies

### Internal
`Imlight.Common` (config, logging); consumed by all of CoreLib's servers.

### External
Akka.NET, .NET sockets.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
