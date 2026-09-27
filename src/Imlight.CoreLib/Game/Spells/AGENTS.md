<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Spells

## Purpose
Spell-side knowledge: building spell objects, the magic school taxonomy, cinematic metadata, and the
filters that decide which spell effects apply in a given context.

## Key Files

| File | Description |
|------|-------------|
| `SpellFactory.cs` | Builds spell objects from templates (consumed by combat, spellbook, cantrips) |
| `MagicSchools.cs` | The magic school taxonomy and lookups |
| `SpellCinematics.cs` | Cinematic/timing metadata for spell presentation |
| `SpellEffectFilter.cs` | Filters which of a spell's effects apply (school focus, target type, ...) |

## For AI Agents

### Working In This Directory
- Spell data is content (spiraldb spellbooks, client spell WADs); this directory is construction and rules only.
- Combat (`Game/Combat`) consumes these types; keep `SpellFactory` pure so both combat and non-combat paths share one construction path.

### Testing Requirements
No unit tests. Cast the spell in a client duel and check the effect and the cinematic.

## Dependencies

### Internal
`Shared/Resources` (templates), `WizardData` (spellbooks), `Imlight.Common`.

### External
Imcodec (object properties, IO).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
