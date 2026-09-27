<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Game

## Purpose
The game server and every game subsystem: the `GameServer` actor, the 25 per-session services, zone/ECS
infrastructure, combat, quest requirements/results, QA commands, groups, effects, spells, and world/zone
instancing. This is where most feature work lands.

## Key Files

| File | Description |
|------|-------------|
| `GameServer.cs` | The game server actor (derives from `Shared/Networking.Server`); hosts GameWorld, services, and session actors for one realm |
| `GameServiceFactory.cs` | Declares the `HashSet<Type> ServiceTypes` of `MessageService`s attached to each joining session. Registering a service here is the whole wiring step for a player-facing feature |
| `WizardObjectLoader.cs` | Boot-time loader that materializes wizard objects from the databases (characters, items, reagent inventories) |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `Services/` | The 25 per-session protocol services (quest, chat, inventory, combat, command, shop, group, ...) (see `Services/AGENTS.md`) |
| `Zone/` | Zone actor, entity/component ECS, supervisors (see `Zone/AGENTS.md`) |
| `Combat/` | Duel resolution: rounds, decks, charms/wards, hit/fizzle, cinematics (see `Combat/AGENTS.md`) |
| `World/` | Zone lifecycle, player transfers, instance creation, access passes (see `World/AGENTS.md`) |
| `Commands/` | QA/test command framework, plus the per-group protocol handlers (see `Commands/AGENTS.md`) |
| `Requirements/` | "Can the player do this?" evaluation: dispatcher, contexts, handlers (see `Requirements/AGENTS.md`) |
| `Results/` | "What happens when they do it": dispatcher, executor actor, contexts, handlers (see `Results/AGENTS.md`) |
| `Groups/` | Cross-realm group/dungeon parties: directory actor, snapshots (see `Groups/AGENTS.md`) |
| `Effects/` | Stat effect rules and canonical effect loading (see `Effects/AGENTS.md`) |
| `Spells/` | Spell factory, magic schools, cinematics, effect filters (see `Spells/AGENTS.md`) |
| `DropTables/` | Loot rolls, converters, granting (see `DropTables/AGENTS.md`) |
| `Processes/` | Long-lived actor processes with inactivity-based teardown (see `Processes/AGENTS.md`) |
| `Minigames/` | Minigame configuration and process (see `Minigames/AGENTS.md`) |
| `Cantrips/` | `CantripFactory`: instant one-shot spell-like items (single file) |
| `Madlibs/` | `QuestMadlibs`: quest text placeholder substitution (single file) |
| `Pet/` | `PetFactory`: pet object construction from templates (single file) |
| `Reagents/` | `ReagentFactory`: reagent object construction (single file) |
| `Sigils/` | `SigilFactory`: sigil object construction (single file) |
| `States/` | `StateFactory`: creature state construction (single file) |
| `WizBang/` | WizBang priority and rules (2 files) |
| `AprilFools/` | `CreatureList`: the April Fools test creature set (single file, test data) |

## For AI Agents

### Working In This Directory
- Read the target subdirectory's AGENTS.md for its extension pattern before writing code.
- The dispatcher/registry idiom dominates: add a handler in the matching `Handlers/` folder and it self-registers; do not hand-edit dispatcher tables.
- Feature placement: player-initiated protocol work goes in `Services/`; world/entity behavior goes in `Zone/Components/`; gating and effects go in `Requirements/` and `Results/`.
- Services reach the player via `GetActiveWizard()` and reply via `SendToSocket(...)`; cross-realm or cross-server traffic goes through `SERVER_100_PROTOCOL.*`.

### Testing Requirements
No unit tests in the solution. Verify with a client: boot the Director, enter a zone, trigger the behavior.

### Common Patterns
- Actor classes derive from `ReceiveProtocolDispatcher` with `[MessageHandler(typeof(...))]` methods.
- Factories (`XFactory`) are pure construction from templates; dispatchers route; supervisors own actors.

## Dependencies

### Internal
`Shared/` (networking, packets, resources), `WizardData/` (models, collections, SpiralDB), `Imlight.Common`.

### External
Akka.NET, Imcodec (generated wire types and IO).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
