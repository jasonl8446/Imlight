<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Effects

## Purpose
Statistical effect rules: building and canonicalizing the stat effects that spells, cantrips, and item
effects apply to characters.

## Key Files

| File | Description |
|------|-------------|
| `GameEffectFactory.cs` | Builds effect objects from templates |
| `CanonicalStatEffects.cs` | Canonical (normalized) stat effect forms used when stacking/resolving |
| `CharacterEffectHelper.cs` | Applies and removes effects on a character |
| `GameEffectRuleData.cs` | The rule data describing how an effect behaves |
| `WizStatisticEffectConfigLoader.cs` | Loads statistic effect configuration from resources |

## For AI Agents

### Working In This Directory
- Effects are computed, then applied: factories and rules produce data, `CharacterEffectHelper` mutates the character. Keep that split.
- Stat names and magnitudes come from game content (spiraldb / WAD); do not hardcode new stat meanings here.

### Testing Requirements
No unit tests. Apply an effect through combat or an item and check the stat values in the client HUD.

## Dependencies

### Internal
`Shared/Behaviors` (stat behaviors), `WizardData` (effect config), `Imlight.Common`.

### External
Imcodec (object property types).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
