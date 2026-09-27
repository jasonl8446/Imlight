<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Processes

## Purpose
The generic "long-lived actor with a lifecycle" framework: an abstract `Process` base with activity tracking
and automatic teardown after 10 minutes of inactivity, plus the supervisor that manages running processes.

## Key Files

| File | Description |
|------|-------------|
| `Process.cs` | Abstract base (a `ReceiveProtocolDispatcher` with timers): 600s inactivity check, start/stop lifecycle |
| `ProcessSupervisor.cs` | Owns and tracks live process actors |

## For AI Agents

### Working In This Directory
- Derive from `Process` to get the inactivity teardown for free (used by `Minigames/MinigameProcess`). Do not bypass the supervisor to create process actors.
- Keep per-process messages flowing to refresh activity while the session is genuinely in play.

### Testing Requirements
No unit tests. Start a process-backed feature (minigame) in-game and confirm it stops when the players leave.

## Dependencies

### Internal
`Shared/Networking`, `Shared/Packets` (PROCESS_107).

### External
Akka.NET.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
