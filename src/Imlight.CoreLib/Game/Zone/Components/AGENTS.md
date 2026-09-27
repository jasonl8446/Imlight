<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Zone/Components

## Purpose
The 30 component types that give zone entities behavior. Interaction components expose
`ServiceName`/`NpcIcon` so the player can click them; the rest drive movement, stats, combat, and
presentation.

## Key Files (by family)

| File | Description |
|------|-------------|
| `NpcComponent.cs` | Base NPC interaction (identity, service presentation) |
| `InteractVendorComponent.cs` / `InteractTreasureVendorComponent.cs` / `InteractDyeShopComponent.cs` / `InteractPotionShopComponent.cs` / `InteractServiceMementoComponent.cs` | Shop and vendor interactions |
| `InteractQuestOfferComponent.cs` / `InteractQuestSelectComponent.cs` / `InteractQuestUnderwayComponent.cs` / `InteractPersonaGoalComponent.cs` | Quest flow stages (offer, select, underway, goal) |
| `InteractTrainerComponent.cs` | Trainer (spell learn) |
| `InteractMinigameComponent.cs` | Minigame entry point (pairs with `Game/Minigames`) |
| `InteractAuctionHouseComponent.cs` | Auction house interaction |
| `InteractDungeonSigilComponent.cs` | Dungeon sigil interaction |
| `InteractTutorialComponent.cs` | Tutorial interaction |
| `InteractReagentComponent.cs` | Reagent interaction |
| `CombatCreatureAIComponent.cs` | Creature AI decisions in combat |
| `CombatCreatureDeckComponent.cs` / `CombatCreatureEquipmentComponent.cs` | Creature deck and equipment in combat |
| `CombatDuelComponent.cs` | The duel state machine on the entity |
| `PathMovementComponent.cs` | Path-based movement |
| `AnimationComponent.cs` / `RenderComponent.cs` | Animation and rendering presentation |
| `StatsComponent.cs` | Stat block |
| `VolumeComponent.cs` | Trigger volume (enter/leave events) |
| `SummonedPetComponent.cs` | Summoned pet behavior |
| `WIspHealthComponent.cs` / `WispManaComponent.cs` | Wisp health/mana pools |
| `WoodenChestComponent.cs` | Wooden chest (loot) |
| `WorldTeleportDoorComponent.cs` | World teleport door |

## For AI Agents

### Working In This Directory
- The idiom (`.agents/AGENT.md` section 8): `internal sealed class XComponent(ZoneEntity entity) : ZoneEntityComponent(entity)` implementing `IComponentFactory`; add `IServiceComponent` (with `ServiceName`/`NpcIcon`) exactly when the player can interact with it.
- Components are attached automatically from the entity template via `ZoneEntityComponentRegistry`; a new component needs no other registration.
- A component's `[MessageHandler]` methods run on the owning entity's actor thread: `Self` arrives as a `ComponentActorRef` routing to this component, `Sender` is the entity's current sender. An exception in a component handler is logged and the entity keeps running.
- Do not `Ask` the owning entity or a sibling component with `.Result`; that thread is the one that would answer.
- Timers: use the component's `IWithTimers` scheduler; `CancelAll` must only cancel this component's timers.

### Testing Requirements
No unit tests. Spawn the entity in a zone with a client and exercise the interaction; watch the entity
actor's log lines for handler exceptions.

## Dependencies

### Internal
`Zone/Core` (base, registry, timers), `Game/Combat`, `Game/Groups`, `Services` (protocol entry), `Shared/Behaviors`, `WizardData`.

### External
Akka.NET, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
