<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Shared/Services

## Purpose
The two base services available on every server (not just game sessions): account-level operations and
server control.

## Key Files

| File | Description |
|------|-------------|
| `AccountService.cs` | Account-scoped protocol handling shared across servers |
| `ControlService.cs` | Server control messages (operational control of connections/sessions) |

## For AI Agents

### Working In This Directory
- These sit below the per-server service families: keep them server-agnostic (no game, no login specifics). A feature that needs realm context belongs in `Game/Services` or `Login/Services`.
- Same service idiom: `MessageService(SessionActor)` with `[MessageHandler]` methods.

### Testing Requirements
No unit tests. Verify the affected flow (account or control) through whichever server you are exercising.

## Dependencies

### Internal
`Shared/Networking`, `Shared/Packets`.

### External
Akka.NET, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
