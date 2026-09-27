<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# DropTables

## Purpose
Loot: converts SpiralDB drop table content into rolls and grants the resulting items to players or zones.

## Key Files

| File | Description |
|------|-------------|
| `DropTableConverter.cs` | Adapts spiraldb drop table structures into the server's roll format |
| `DropTableRoller.cs` | The roll itself: weights, conditions, outcomes |
| `LootGranter.cs` | Grants rolled items to the target (player inventory, world drop, group split) |

## For AI Agents

### Working In This Directory
- Drop tables are content, not code: the tables live in `spiraldb-cache/DropTables/` (SpiralDB). A missing drop is a content gap first.
- Keep roll and grant separated: the roller decides what drops, the granter decides where it goes.

### Testing Requirements
No unit tests. Trigger a drop through a client (defeat a creature or open a chest) and compare the loot
against the spiraldb table.

## Dependencies

### Internal
`WizardData` (drop tables, wizard items), `Shared/Items`.

### External
Imcodec (item object types).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
