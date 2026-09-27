<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# WizardData/Models/World

## Purpose
The world content document shapes, hydrated from the SpiralDB repository (see `spiraldb-reference.md` in
`docs/` for the content conventions). These are read-mostly and loaded at boot.

## Key Files

| File | Description |
|------|-------------|
| `CreatureSpellbook.cs` | A creature's spellbook |
| `DropTable.cs` | A drop table definition |
| `NpcInventory.cs` | A NPC's inventory (vendor goods, chest contents) |
| `NpcSpellInventory.cs` | A merchant's sellable spells |
| `NpcDropTable.cs` | A creature-specific drop table binding |
| `NpcTreasureCardInventory.cs` | A treasure chest's card inventory |
| `GlobalRegistryModel.cs` | The global registry (shared world constants and flags) |
| `NPCStates.cs` | NPC state definitions |
| `WizardZoneData.cs` | Zone data for a wizard101 zone (the shape the `Zone` actor consumes) |

## For AI Agents

### Working In This Directory
- These models mirror the SpiralDB JSON; a mismatch between the model and the content breaks loading at
  boot (with a rollback on remote-sync failure). When content changes shape, update the model first and
  verify the boot load.
- They are read by `Collections` (world `Preload*`) and `Game/World`; do not mutate them at runtime.
- Keys are ids: creatures and NPCs key by `ulong` ids, quests and registry entries by name.

### Testing Requirements
No unit tests. Boot the Director (SpiralDB load is logged) and confirm the affected content (vendor stock,
drop, zone) appears in-game.

## Dependencies

### Internal
`WizardData` (SpiralDB, collections), consumed by `Game/World`, `Game/Combat`, `Zone`.

### External
Newtonsoft.Json (annotation attributes mirror the content schema).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
