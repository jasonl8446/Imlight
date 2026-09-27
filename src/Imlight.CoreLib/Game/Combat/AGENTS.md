<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Combat

## Purpose
The duel engine: round-based combat resolution for player vs player, player vs creature, and tutorial
fights. Owns the math and sequencing; `Zone/Components/CombatDuelComponent` owns the duel's state machine
on the entity side.

## Key Files

| File | Description |
|------|-------------|
| `CombatResolver.cs` | Entry point for per-round resolution: queued moves, hit/fizzle, accuracy, target order, cinematic timing (`Reset`, `AddCombatMove`, `ApplyQueuedCombatActions`) |
| `CombatActionResolver.cs` | Processes queued actions and resolves target selection |
| `CombatDuelSubCircle.cs` | Per-participant state and position (a "sub circle" of the duel) |
| `CombatDeck.cs` / `CombatDeckSpellData.cs` | Spell deck management: draw, discard, deck spell data |
| `CombatEffectApplicator.cs` | Applies spell effects with modifier chain |
| `CombatCharms.cs` / `CombatWards.cs` | Offensive (outgoing damage/heal) and defensive (incoming damage) modifiers |
| `CombatCriticals.cs` | Critical hit rules |
| `CombatEffectStack.cs` | Random/variable effect selection using bit-packing |
| `CombatGroupReservations.cs` | Reserving group slots during combat |
| `CombatEnums.cs` | Shared combat enums and move types |
| `TutorialDuelDirector.cs` | Runs the scripted tutorial duels |

## For AI Agents

### Working In This Directory
- The class map in `CombatResolver.cs`'s header is the authoritative role split; consult it before moving responsibility between classes.
- Hit/fizzle and accuracy are client-visible behavior: the client animates what the server reports, so keep the resolution output contract stable.
- Combat state lives in `Zone/Components/CombatDuelComponent` (duel) and the sub circles; this directory is pure resolution logic over that state.

### Testing Requirements
No unit tests. Verify by entering combat with a client (duel flow, hit/fizzle, deck cycles).

## Dependencies

### Internal
`Game/Spells` (spell data), `Shared/Behaviors` (stats, inventory), `Shared/Resources`, `WizardData/Collections` (spellbooks, decks).

### External
Imcodec (message types, crypto, IO).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
