<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Groups

## Purpose
Cross-realm groups (dungeon parties and social groups). One `GroupDirectory` actor owns all group state;
every other code path reads immutable `GroupSnapshot`s.

## Key Files

| File | Description |
|------|-------------|
| `GroupDirectory.cs` | The actor that owns and mutates every group. Lives under the login server's `GameServerPool` because groups span all realms (see `GameServerPool` header) |
| `Group.cs` | Mutable state of a single group: members, join order, leadership, quest binding, sigil slots, pending invites. Only the directory mutates it |
| `GroupSnapshot.cs` | Immutable read view handed to readers |
| `GroupMemberProfile.cs` | Per-member profile within a group |
| `GroupRegistry.cs` | Id allocation and lookup for groups |

## For AI Agents

### Working In This Directory
- Invariants from `Group.cs`: a group exists the moment its founder sends the first invite but is not announced until a second member joins; members keep join order and the earliest remaining member inherits leadership. Preserve both when touching membership.
- Never hold or copy a `Group` reference outside the directory actor; snapshot instead.
- Cross-realm queries (who is in this party on another realm) go through the directory, not through a game server.

### Testing Requirements
No unit tests. Form a party with a client, join from another realm if possible, and confirm announcement and
leadership rules.

## Dependencies

### Internal
`Shared/Networking` (actors, messages), `Shared/Packets` (GROUP_109), `Login/GameServerPool` (ownership).

### External
Akka.NET, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
