<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# WizardData/Models

## Purpose
The document model types of both stores, split by ownership: player-owned documents, world content
documents, and operational misc documents.

## Key Files
Directory container; see the Subdirectories table.

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `Player/` | `Wizard`, `Account`, `QuestInstance`, `Relationship`, `DyeColor`, `Dynamod`, `EquipmentSlot` (see `Player/AGENTS.md`) |
| `World/` | SpiralDB-backed world documents: `CreatureSpellbook`, `DropTable`, `NpcInventory`, `NpcDropTable`, `NpcSpellInventory`, `NpcTreasureCardInventory`, `GlobalRegistryModel`, `NPCStates`, `WizardZoneData` (see `World/AGENTS.md`) |
| `Misc/` | Operational documents: `ChatLog`, `InfractionModels`, `OnlinePlayer`, `ScoreTracking` (see `Misc/AGENTS.md`) |

## For AI Agents

### Working In This Directory
- Models are data shapes only: no behavior, no database calls. Access goes through `Collections`.
- Serialization is Newtonsoft.Json with `TypeNameHandling.Auto` on the SpiralDB side; adding a field is
  additive, renaming or retyping is a migration.
- Which folder a model belongs to is an ownership question (does a player own it, the world, or the
  ops side?), not a size question.

### Testing Requirements
No unit tests. Verify via the feature that reads/writes the document, with a client.

## Dependencies

### Internal
Consumed by `WizardData/Collections`, `Auth`, `Game`, `Login`.

### External
Newtonsoft.Json attrs (serialization annotations).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
