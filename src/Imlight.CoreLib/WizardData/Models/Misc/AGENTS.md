<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# WizardData/Models/Misc

## Purpose
Operational document shapes: audit logs, online tracking, infractions, and score tracking.

## Key Files

| File | Description |
|------|-------------|
| `ChatLog.cs` | A chat log entry (audit) |
| `InfractionModels.cs` | Infraction/punishment document shapes (bans, warnings, machine/IP bans) |
| `OnlinePlayer.cs` | An online session record |
| `ScoreTracking.cs` | Score/tracking entries for players |

## For AI Agents

### Working In This Directory
- These are append-mostly audit documents; the writers are the `ChatLogCollection`, `CommandLogCollection`,
  `InfractionCollection`, `OnlinePlayerCollection`, and `ScoreTrackingCollection` accessors.
- `InfractionModels.cs` is multi-shape by name (bans, machine bans, IP bans); keep all related types in the
  single file rather than splitting.

### Testing Requirements
No unit tests. Trigger the flow (chat, a punishment via commands) and confirm the rows land in the store.

## Dependencies

### Internal
`WizardData/Collections` (persistence), `Auth` (ban checks), `Game/Commands` (punishment write path).

### External
Newtonsoft.Json (annotations).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
