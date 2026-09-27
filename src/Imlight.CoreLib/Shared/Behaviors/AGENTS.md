<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Shared/Behaviors

## Purpose
The server-side mirrors of the client's own behavior objects. Each `Server*Behavior` class implements
`IClientBehaviorProvider<ClientBehaviorType>` so that player-facing state can be attached to objects and
shaped the way the client expects, with limits and defaults read from configuration.

## Key Files (by concern)

| File | Description |
|------|-------------|
| `ServerWizInventoryBehavior.cs` | Inventory behavior: item list, `NoTransfer` flag, `Character.MaxInventoryItems` limit with a safe fallback of 20, jewel cap |
| `ServerWizEquipmentBehavior.cs` | Equipment slots |
| `ServerWizSpellbookBehavior.cs` / `ServerSpellbookBehavior.cs` | Spellbook state |
| `ServerWizPlayerNameBehavior.cs` | Player name behavior |
| `ServerWizGameStats.cs` | Game stats (the server-side stat block) |
| `ServerQuestBehavior.cs` | Quest state on the object |
| `ServerFriendBehavior.cs` | Friend/relationship state |
| `ServerObjectStateBehavior.cs` | Object state flags |
| `ServerAlchemyBehavior.cs` | Alchemy behavior |
| `ServerMountOwnerBehavior.cs` / `ServerPetOwnerBehavior.cs` / `ServerPetSnackBehavior.cs` | Mount and pet ownership, pet snacks |
| `ServerMagicSchoolBehavior.cs` / `MagicSchoolIndex.cs` | Magic school state and index |
| `IClientBehaviorProvider.cs` | The provider contract tying a server behavior to its client behavior type |

## For AI Agents

### Working In This Directory
- A behavior wraps state and helpers for one client behavior type; it is not an actor. Attach it where the client expects it (player object, item, zone object).
- Limits come from `ConfigurationManager` settings; the existing fallbacks (e.g. inventory min 20) guard against misconfiguration and should be preserved.
- If you add a behavior, find its companion `Client*Behavior` type in Imcodec and implement `IClientBehaviorProvider` against it, matching the existing naming (`ServerXxxBehavior` <-> `ClientXxxBehavior`).

### Testing Requirements
No unit tests. Verify the affected client feature (inventory, spellbook, friend list, mount) in-game after
a behavior change.

## Dependencies

### Internal
`Imlight.Common` (config), `WizardData` (player/character models), Imcodec client behavior types.

### External
Imcodec (object property types), Newtonsoft.Json (serialization).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
