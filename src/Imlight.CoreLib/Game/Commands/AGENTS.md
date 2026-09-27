<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Commands

## Purpose
The QA/testing command framework: chat-style commands dispatched to per-group protocol handlers. Explicitly
for QA testing purposes, not player features (see `CommandDispatcher.cs` header).

## Key Files

| File | Description |
|------|-------------|
| `CommandDispatcher.cs` | Actor that routes `[group] [command] [parameters]` lines to the matching `CommandProtocol` handler; protocols self-register via reflection; groupless commands key under the `nogroup` prefix |
| `CommandContext.cs` | The per-invocation context handed to handlers (sender, player, zone) |
| `CommandProtocol.cs` | Base contract every command group implements |
| `CommandAttributes.cs` | Attribute definitions for command registration |
| `CommandUtilities.cs` | Shared parsing/formatting helpers for handlers |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `Protocols/` | One file per command group: `CommandCheatProtocol`, `CommandDebugProtocol`, `CommandQuestProtocol`, `CommandSpellbookProtocol`, `CommandTeleport`, `CommandGroupProtocol`, `CommandModifyProtocol`, `CommandDynaModProtocol`, `CommandAccountProtocol`, `CommandBanProtocol`, `CommandUnbanProtocol`, `CommandPunishmentProtocol` (see `Protocols/AGENTS.md`) |

## For AI Agents

### Working In This Directory
- Add a new command by extending the matching protocol in `Protocols/` (or a new one that implements `CommandProtocol`); the dispatcher discovers it, do not edit the routing table.
- These commands are the fastest way to drive the server for verification (give spells, teleport, ban/unban, inspect dyna mod). Prefer them over database edits during testing.
- Keep the QA framing: commands must not become player-accessible features.

### Testing Requirements
No unit tests. Run the command through the in-game chat of a client session and observe the effect.

## Dependencies

### Internal
`Services/CommandService` entry point, `Shared/Packets` (SERVER_100), `WizardData(Collections)`, `Imlight.Common`.

### External
Imcodec (message types).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
