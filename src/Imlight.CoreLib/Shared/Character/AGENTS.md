<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Shared/Character

## Purpose
Character-level helpers shared by servers: building buddy (friend) stats and their CRC, general
character helpers, and the magic level configuration.

## Key Files

| File | Description |
|------|-------------|
| `BuddyStatsBuilder.cs` | Builds the friend/buddy stats payload shown in the client |
| `BuddyStatsCrc.cs` | CRC over the buddy stats payload (client integrity check) |
| `CharacterHelper.cs` | Cross-cutting character helpers |
| `MagicLevelsConfig.cs` | Magic level thresholds/settings from config |

## For AI Agents

### Working In This Directory
- The client validates the buddy stats CRC (`BuddyStatsCrc`); builder and CRC must stay paired or friend
  list display breaks.
- Level and threshold values come from configuration or content; do not hardcode new ones here.

### Testing Requirements
No unit tests. Verify the friend list and magic level display in a client after changes.

## Dependencies

### Internal
`Imlight.Common`, `WizardData` (character/relationship models).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
