<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Services

## Purpose
The 25 per-session protocol services attached to every game-session actor by `GameServiceFactory`. Each
service owns one player-facing protocol area and is the correct home for new player-initiated features.

## Key Files

| File | Description |
|------|-------------|
| `QuestService.cs` | Quest offer, accept, progress, turn-in (the largest service) |
| `CombatService.cs` | Player-side combat protocol (moves, deck actions, surrender) |
| `InventoryService.cs` / `EquipmentService.cs` | Item inventory and equipment slots |
| `ChatService.cs` | Chat routing (channel, whisper, group) |
| `CommandService.cs` | Entry point that hands in-game chat lines to `Game/Commands` |
| `ZoneService.cs` | Player-to-zone protocol (enter, move, cull, query) |
| `MoveService.cs` | Movement and position authority |
| `ShopService.cs` / `TreasureShopService.cs` | Vendor shops and treasure chests |
| `AuctionHouseService.cs` | Auction house flow |
| `PetService.cs` / `PotionService.cs` / `CantripService.cs` | Pet, potion, cantrip interactions |
| `GroupService.cs` | Party/social group protocol (talks to `Game/Groups` directory) |
| `FriendsService.cs` | Buddies and relationships |
| `SpellBookService.cs` / `TrainService.cs` | Spellbook management and trainer interaction |
| `DynaModService.cs` | Dynamic mod (merchant/player modifiers) |
| `AttachService.cs` | Service attachment handshake |
| `ClientService.cs` | Generic client protocol |
| `InteractService.cs` | In-world object interaction dispatch |
| `MinigameService.cs` | Minigame entry (pairs with `Game/Minigames`) |
| `TutorialService.cs` | Tutorial flow |
| `WizardService.cs` | Wizard/character-level operations |

## For AI Agents

### Working In This Directory
- The idiom (from `.agents/AGENT.md` section 8): `internal sealed class XService(SessionActor sessionActor) : MessageService(sessionActor)`, private handlers tagged `[MessageHandler(typeof(X_PROTOCOL.MSG_Y))]`, `GetActiveWizard()` to reach the player, `SendToSocket(...)` to reply, `protected static Props(...)` factory.
- Registering a new service in `GameServiceFactory.ServiceTypes` is the entire wiring step.
- Client wire message types come from `Imcodec.MessageLayer.Generated` (e.g. `LOGIN_7_PROTOCOL`, used by `Login/Services`); never define them here.
- Large services are split by protocol area, not by file size; if a service spans two protocol families, split it.

### Testing Requirements
No unit tests. Verify each touched service through the client protocol it implements.

## Dependencies

### Internal
`Shared/Networking` (MessageService, SessionActor), `Shared/Behaviors`, `WizardData`, sibling subsystems (`Groups`, `Minigames`, `DropTables`, `Combat`).

### External
Akka.NET, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
