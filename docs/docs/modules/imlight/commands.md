# Commands

Imlight has a built-in command framework for QA and moderation. Commands are typed into the client chat
box with a `.` prefix and are only accepted from accounts whose authority is above `None`. They are
explicitly a test and moderation surface, not player features.

The implementation lives in `src/Imlight.CoreLib/Game/Commands/` (dispatcher, context, protocol base)
and `src/Imlight.CoreLib/Game/Commands/Protocols/` (the command groups below). The framework itself, and
how to add new commands, is documented on the [Command System](./gameserver/commands.md) page.

## Security tiers

Authority levels, from `AuthLevel` in the account model:

| Level | Name | Notes |
| ----- | ---- | ----- |
| `0` | None | Cannot use commands (the chat gate requires greater than None) |
| `1` | Quality Assurance | Most testing commands |
| `2` | Hall Monitor | Moderation: accounts, bans, mutes, kicks |
| `3` | Developer | In release builds a requirement at this level is raised to Administrator; no command currently requires it |
| `4` | Administrator | The most privileged account commands |

Some commands additionally compare the target account's authority to yours; you cannot lock, delete, warn,
or change the authority of an account whose level is higher than your own, nor of your own account where the
code says so (noted per command below).

## How to invoke a command

- Type `.` then the command in chat: `.mod level 11`. The prefix is stripped before dispatch.
- Commands are `group command parameters`. The group is the first word (`mod`, `sb`, `account`, ...).
- Several commands live without a group (`teleport`, `mute`, `kick`, ...); type them directly after the `.`.
- Type a group name alone, or with `help` or `?`, to list its commands: `.account`, `.sb help`.
- Wrong argument counts reply with a usage line in the form `command ($param1) ($param2...)`;
  a `...` on a parameter means "and everything after it" (the remainder, which may contain spaces).
- Durations are written as an anchored combo of `d`/`h`/`m`/`s` parts in that order, e.g. `4d20h3m`. At
  least one numeric part is required.
- Every command use is written to the server command log and the account's log.
- Commands reply through the client's server-message box; errors and permission denials use the modal (important) box.

## Player selection (context commands)

The ungrouped moderation commands (`mute`, `unmute`, `kick`, `warn`, `info`) act on the **selected**
account, not on the account name. Select a player first (buddy/player select), then run the command.
The selection stays set until you select someone else, so re-select after a while to avoid acting on a
stale target.

## Ungrouped commands

| Command | Aliases | Security | Syntax | Description |
| ------- | ------- | -------- | ------ | ----------- |
| `teleport` | `tp`, `port` | Quality Assurance | `.teleport $zonename` | Teleports you to a zone. The match accepts a substring of a full zone name. |
| `mute` | | Hall Monitor | `.mute $duration $reason...` | Mutes the selected account for a duration. Requires a player selection. |
| `unmute` | | Hall Monitor | `.unmute` | Waives the selected account's current mute. |
| `kick` | | Hall Monitor | `.kick [$reason...]` | Kicks the selected account from the server. |
| `warn` | | Hall Monitor | `.warn $reason...` | Adds a warning infraction to the selected account. |
| `info` | | Hall Monitor | `.info` | Shows the selected account's details (auth, last login, machine/IP, lock and ban state, character IDs). |

`teleport` also understands GM island shortcuts that require Hall Monitor authority: `gm`, `gmisland`,
`gm_island`, `gmis`, `gm_is`, `gm_isl`, `gm_isla`, `gm_islan`, `gm_island`; they all go to
`WizardCity/QA_SpawnRate`.

## Account group (`account`)

| Command | Aliases | Security | Syntax | Description |
| ------- | ------- | -------- | ------ | ----------- |
| `create` | | Hall Monitor | `.account create $username $password` | Creates a new account. |
| `delete` | | Administrator | `.account delete $username` | Deletes an account. Blocked for your own account and for accounts with a higher authority than yours. |
| `lock` | | Hall Monitor | `.account lock $username` | Locks an account (login refused). Blocked for higher authority than yours. |
| `unlock` | | Hall Monitor | `.account unlock $username` | Unlocks an account. |
| `password` | | Administrator | `.account password $username $newPassword $confirm` | Changes an account's password; the two passwords must match. |
| `authlevel` | | Administrator | `.account authlevel $username $level` | Sets the account's authority level, `0` through `4`. Blocked for your own account and for higher authority than yours. |
| `info` | | Hall Monitor | `.account info $username` | Shows account details (same fields as the selected-account `info`). |
| `infractions` | `warns`, `warnings` | none (any command user) | `.account infractions $username` | Lists the account's infraction history with times, moderators, and reasons. |
| `warn` | | Hall Monitor | `.account warn $username $reason...` | Adds a warning infraction to the named account. |
| `removewarn` | | Hall Monitor | `.account removewarn $username $index` | Removes the infraction at the 1-based index shown by `infractions`. |

## Ban group (`ban`)

| Command | Aliases | Security | Syntax | Description |
| ------- | ------- | -------- | ------ | ----------- |
| `account` | `user`, `username` | Hall Monitor | `.ban account $username $duration $reason...` | Bans an account (all its characters) for a duration; kicks it immediately if online. Fails if already banned. |
| `machine` | `pc`, `computer` | Hall Monitor | `.ban machine $machineId $duration $reason...` | Bans a machine ID for a duration. Fails if already banned. |
| `ip` | | Hall Monitor | `.ban ip $ip $duration $reason...` | Bans an IP address for a duration. Fails if already banned. |
| `info` | | Hall Monitor | `.ban info $username` | Shows ban and mute state with end times, and the last infraction, for an account. |

## Unban group (`unban`)

| Command | Aliases | Security | Syntax | Description |
| ------- | ------- | -------- | ------ | ----------- |
| `account` | `user`, `username` | Hall Monitor | `.unban account $username` | Waives an account's current ban. |
| `machine` | `pc`, `computer` | Hall Monitor | `.unban machine $machineId` | Removes a machine ID ban. |
| `ip` | | Hall Monitor | `.unban ip $ip` | Removes an IP ban. |

## Cheat group (`cheat`)

Combat test switches; each toggle applies to your own duels only.

| Command | Aliases | Security | Syntax | Description |
| ------- | ------- | -------- | ------ | ----------- |
| `win` | | Quality Assurance | `.cheat win` | Instant-victories the current duel. |
| `cinematic` | | Quality Assurance | `.cheat cinematic` | Toggles instant cinematics. Effects still resolve; only the pacing collapses. |
| `nofizzle` | | Quality Assurance | `.cheat nofizzle` | Toggles no-fizzle. The accuracy roll always succeeds; dispel wards still apply. |

## Debug group (`debug`)

| Command | Aliases | Security | Syntax | Description |
| ------- | ------- | -------- | ------ | ----------- |
| `gps` | | Quality Assurance | `.debug gps` | Shows your server-stored position, rotation, and zone. |
| `disableobj` | | Quality Assurance | `.debug disableobj $zoneTag...` | Puts the matching zone object into its `Off` state, visible to you only. |
| `enableobj` | | Quality Assurance | `.debug enableobj $zoneTag...` | Puts the matching zone object into its `On` state, visible to you only. |
| `setstate` | | Quality Assurance | `.debug setstate $stateName $zoneTag...` | Sends an arbitrary state (for example `IdleOpen` on a gate) to the matching object, visible to you only. |

## DynaMod group (`dynamod`)

| Command | Aliases | Security | Syntax | Description |
| ------- | ------- | -------- | ------ | ----------- |
| `list` | | Quality Assurance | `.dynamod list` | Lists your character's current dynamods and states. |
| `set` | | Quality Assurance | `.dynamod set $state $clientTag...` | Sets a dynamod to a state: `on`, `off`, or a named state such as `IdleOpen`. Creates the entry if missing. |
| `toggle` | | Quality Assurance | `.dynamod toggle $clientTag...` | Toggles a dynamod between `on` and `off`. |
| `remove` | | Quality Assurance | `.dynamod remove $clientTag...` | Removes a dynamod from your character. |

::: tip
`$clientTag` may contain spaces, so it is always the last argument (the remainder). It must match the
object's zone tag exactly (case-insensitive).
:::

## Group group (`group`)

These act on **your own** group with your own leader rights: `kick`, `leader`, and `disband` only work if
you are the leader, the same rules the client follows.

| Command | Aliases | Security | Syntax | Description |
| ------- | ------- | -------- | ------ | ----------- |
| `info` | | Quality Assurance | `.group info` | Lists group members with leader flag, zone, and sigil slot. |
| `kick` | `remove` | Quality Assurance | `.group kick $name...` | Removes a member. |
| `leader` | | Quality Assurance | `.group leader $name...` | Makes another member the leader. |
| `disband` | | Quality Assurance | `.group disband` | Disbands the group. |

::: tip
`$name` is the member's full wizard name; it may contain spaces and is always the last argument. Matching
is case-insensitive.
:::

## Modify group (`mod`)

All change your own character.

| Command | Aliases | Security | Syntax | Description |
| ------- | ------- | -------- | ------ | ----------- |
| `levelup` | `lvlup` | Quality Assurance | `.mod levelup` | Levels your character up by one (refuses past the max level). |
| `level` | | Quality Assurance | `.mod level $level` | Sets your level directly (must be at or below the max level). |
| `speed` | | Quality Assurance | `.mod speed $multiplier` | Applies a speed multiplier effect (for example `40` for mount speed). |
| `additem` | | Quality Assurance | `.mod additem $templateId` | Adds an item by template ID. Pet templates are added as hatched pets; non-item templates are refused. |
| `addsnack` | | Quality Assurance | `.mod addsnack $templateId` | Adds a pet snack by template ID; only snack templates are accepted. |
| `addreagent` | | Quality Assurance | `.mod addreagent $templateId` | Adds a reagent by template ID; only reagent templates are accepted. |
| `name` | | Quality Assurance | `.mod name $newName...` | Sets a name override; relog to see it. |
| `badge` | | Quality Assurance | `.mod badge $badgeId...` | Sets a badge override (a locale ID to display); relog to see it. |
| `maxgold` | | Quality Assurance | `.mod maxgold $amount` | Sets the gold cap. |
| `addgold` | | Quality Assurance | `.mod addgold $amount` | Adds gold. |
| `maxhealth` | `maxhp` | Quality Assurance | `.mod maxhealth $amount` | Sets base health. |
| `maxmana` | | Quality Assurance | `.mod maxmana $amount` | Sets base mana. |
| `maxenergy` | `maxnrg` | Quality Assurance | `.mod maxenergy $amount` | Sets pet energy max. |
| `currenthealth` | `currenthp` | Quality Assurance | `.mod currenthealth $amount` | Sets current health (clamped to base). |
| `currentmana` | | Quality Assurance | `.mod currentmana $amount` | Sets current mana (clamped to base). |
| `currentenergy` | `currentnrg` | Quality Assurance | `.mod currentenergy $amount` | Sets current pet energy (clamped to max). |
| `refillhealth` | `refillhp`, `heal` | Quality Assurance | `.mod refillhealth` | Full health. |
| `refillmana` | `refillmp`, `rejuvenate`, `rejuv` | Quality Assurance | `.mod refillmana` | Full mana. |
| `refillenergy` | `refillen`, `refillnrg`, `refillpet`, `energize` | Quality Assurance | `.mod refillenergy` | Full pet energy. |
| `cantriplevelup` | `clvlup` | Quality Assurance | `.mod cantriplevelup` | Levels the cantrip up by one (max 10). |
| `cantriplevel` | `clvl` | Quality Assurance | `.mod cantriplevel $level` | Sets the cantrip level directly (max 10). |
| `addtrainingpoints` | `addtp` | Quality Assurance | `.mod addtrainingpoints $points` | Adds training points. |
| `settrainingpoints` | `settp` | Quality Assurance | `.mod settrainingpoints $points` | Sets training points. |
| `potionmax` | `pmax` | Quality Assurance | `.mod potionmax $amount` | Sets the potion max and fills the charge. |
| `addxp` | | Quality Assurance | `.mod addxp $amount` | Awards XP. |

## Quest group (`quest`)

| Command | Aliases | Security | Syntax | Description |
| ------- | ------- | -------- | ------ | ----------- |
| `offer` | | Quality Assurance | `.quest offer $questName` | Offers a quest to you by name (must exist in SpiralDB and be new to you), with its info dialog, starting goals, and rewards. |
| `remove` | | Quality Assurance | `.quest remove $questName` | Removes a quest from your quest log (case-insensitive). |

## Spellbook group (`sb`)

Spell IDs are spell template IDs.

| Command | Aliases | Security | Syntax | Description |
| ------- | ------- | -------- | ------ | ----------- |
| `learn` | | Quality Assurance | `.sb learn $spellId` | Permanently learns a spell. |
| `unlearn` | | Quality Assurance | `.sb unlearn $spellId` | Unlearns a learned spell. |
| `unlearnall` | | Quality Assurance | `.sb unlearnall` | Unlearns every spell in the book. |
| `add` | | Quality Assurance | `.sb add $spellId` | Adds a temporary spell (hand-sized play). |
| `remove` | | Quality Assurance | `.sb remove $spellId` | Removes a temporary spell. |
| `allcantrips` | | Quality Assurance | `.sb allcantrips` | Learns the full cantrip set in one command. |

## Keeping this page current

This list is generated from the `[Command]`/`[Alias]`/`[AuthRequired]` attributes in
`src/Imlight.CoreLib/Game/Commands/Protocols/`. When a command is added, changed, or removed there,
update the matching table in the same change.
