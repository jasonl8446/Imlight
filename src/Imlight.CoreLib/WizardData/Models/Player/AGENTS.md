<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# WizardData/Models/Player

## Purpose
The player-owned document shapes: the character, the account, and the per-player state that defines a
wizard.

## Key Files

| File | Description |
|------|-------------|
| `Wizard.cs` | The character document: identity, level, stats, behaviors, inventory linkage (the central player document) |
| `Account.cs` | The account: credentials link, characters, infractions reference |
| `QuestInstance.cs` | A player's quest state (template, goals, progress, rewards) |
| `Relationship.cs` | A buddy/friend relationship row |
| `DyeColor.cs` | A owned dye color |
| `Dynamod.cs` | A dynamic modifier entry (merchant/player adjustments) |
| `EquipmentSlot.cs` | An equipment slot binding |

## For AI Agents

### Working In This Directory
- `Wizard` is the document `GetActiveWizard()` returns to services: treat its fields as part of the service
  contract. Adding a field is fine; changing the meaning of an existing one is a migration.
- Player documents are the only data that may change at runtime; keep `World/` models out of these files.

### Testing Requirements
No unit tests. Verify the feature that persists the document (character change, quest progress, friendship)
via a client and confirm persistence across a restart.

## Dependencies

### Internal
`WizardData/Collections` (persistence), consumed by `Auth`, `Game`, `Login`.

### External
Newtonsoft.Json (annotations).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
