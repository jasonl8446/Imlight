<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Login

## Purpose
The login server: the `LoginServer` actor, its per-session services (authentication, character list, game
transition, AFK handling), and the `GameServerPool` that decides which game server a player lands on and
tracks player location across realms.

## Key Files

| File | Description |
|------|-------------|
| `LoginServer.cs` | The login server actor (derives from `Shared/Networking.Server`); owns socket intake and session actors |
| `LoginServiceFactory.cs` | Declares the `ServiceTypes` attached to each login session: `AuthenticatorService`, `CharacterService`, `GameTransitionService`, `LoginAFKService` |
| `GameServerPool.cs` | Actor that manages the game server pool: creation (`MSG_CREATEGAMESERVER`), best-server selection by player limit, realm-to-port mapping. Also owns the one cross-realm `GroupDirectory` actor, since groups span every realm |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `Services/` | The four login-session services (see `Services/AGENTS.md`) |

## For AI Agents

### Working In This Directory
- The pool is the only place that maps realms to game server ports and the only place that may create game server actors (`SERVER_100_PROTOCOL.MSG_CREATEGAMESERVER`); the Director asks it, it enforces `Game Server.MaxGameServersAllowed`.
- Because groups span realms, `GroupDirectory` lives under the pool, not under any game server. Do not re-home it.
- The login server is the first hop clients touch after patch; `Auth/*` (in `../Auth/`) is called from here.

### Testing Requirements
No unit tests. Verify by booting the Director and connecting a client through login into a realm.

## Dependencies

### Internal
`Shared/Networking`, `Shared/Packets` (SERVER_100), `Auth/`, `Game/Groups` (directory ownership), `WizardData` (accounts, session keys).

### External
Akka.NET, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
