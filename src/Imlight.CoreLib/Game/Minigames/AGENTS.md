<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Minigames

## Purpose
In-world minigame play (e.g. the round-based mini duels): configuration plus the long-lived process that
runs a session.

## Key Files

| File | Description |
|------|-------------|
| `MinigameConfig.cs` | Config for a minigame instance (participants, board/round setup) |
| `MinigameProcess.cs` | The minigame as a `Game/Processes.Process`: lifecycle, turn flow, teardown on inactivity |

## For AI Agents

### Working In This Directory
- A minigame enters and leaves the world through the `InteractMinigameComponent` zone component and the
  `MinigameService` player service; this directory owns only the rules and the running session.
- Processes die after 10 minutes of inactivity by design (`Process` base). If a minigame needs to outlive
  that, raise it as a design question, do not silence the timer.

### Testing Requirements
No unit tests. Trigger the minigame from an in-game object with a client and play a full round.

## Dependencies

### Internal
`Game/Processes`, `Game/Services` (entry), `Shared/Behaviors`.

### External
Akka.NET, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
