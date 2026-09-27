<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Login/Services

## Purpose
The four services attached to each login session by `LoginServiceFactory`: authentication, character
listing, game server transition, and AFK handling.

## Key Files

| File | Description |
|------|-------------|
| `AuthenticatorService.cs` | Runs the login auth protocol against `Auth/UserAuthenticator` + `Auth/UserValidator` and the `Auth/AuthorityRequester` authority exchange |
| `CharacterService.cs` | Character list fetch for the login screen |
| `GameTransitionService.cs` | Hands a logged-in player to a game server: server list request (a bare `MSG_SERVERLIST` acknowledgment), character selection, connection handoff. Note the header TODO: the LoginServer name is still hardcoded |
| `LoginAFKService.cs` | AFK/timeout handling on login sessions |

## For AI Agents

### Working In This Directory
- Same service idiom as `Game/Services` (see its AGENTS.md): `internal class XService(SessionActor sessionActor) : MessageService(sessionActor)` with `[MessageHandler]` private methods.
- Auth and crypto belong to `../../Auth/` and `Shared/Cryptography`; the services orchestrate, they do not re-implement.
- The transition path is where a client moves from login to a realm; keep the `GameServerPool` (parent directory) as the authority on which server the player lands on.

### Testing Requirements
No unit tests. Walk the full login flow with a client: auth, character select, enter realm, reconnect.

## Dependencies

### Internal
`Login/` (pool), `Auth/`, `Shared/Networking`, `Shared/Packets` (LOGIN_108), `WizardData` (characters, session keys).

### External
Akka.NET, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
