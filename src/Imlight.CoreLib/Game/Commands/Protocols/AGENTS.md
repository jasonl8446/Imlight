<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Commands/Protocols

## Purpose
The per-group command handlers for the QA framework. One class per command group, each discovered by
`CommandDispatcher` at startup.

## Key Files

| File | Description |
|------|-------------|
| `CommandCheatProtocol.cs` | Cheat commands (items, stats, flags) |
| `CommandDebugProtocol.cs` | Debug inspection commands |
| `CommandQuestProtocol.cs` | Quest state manipulation |
| `CommandSpellbookProtocol.cs` | Learn/give spells |
| `CommandTeleport.cs` | Zone and coordinate teleports |
| `CommandGroupProtocol.cs` | Group manipulation |
| `CommandModifyProtocol.cs` | Object/character modification |
| `CommandDynaModProtocol.cs` | Dynamic mod (per-merchant, per-player) inspection and changes |
| `CommandAccountProtocol.cs` | Account-level commands |
| `CommandBanProtocol.cs` / `CommandUnbanProtocol.cs` | Account and IP/machine bans and unbans |
| `CommandPunishmentProtocol.cs` | Infraction/punishment flows |

## For AI Agents

### Working In This Directory
- Follow the existing handler shape: inherit the protocol contract, expose the command names, act through the `CommandContext`.
- Destructive handlers (ban, punishment, modify) already have log lines; keep logging whatever state they change.

### Testing Requirements
No unit tests. Exercise one command per group through a client chat session; confirm the effect and the log.

## Dependencies

### Internal
`Game/Commands` (dispatcher, context), `Game/Services`, `WizardData` (accounts, infractions, dyna mod).

### External
Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
