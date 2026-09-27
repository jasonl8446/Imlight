<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Auth

## Purpose
Login-time account security, all static (no actors): initial authentication, post-login validation, and the
server-authority exchange. Consumed by the login server's `AuthenticatorService` and by `Shared/Cryptography`.

## Key Files

| File | Description |
|------|-------------|
| `UserAuthenticator.cs` | Initial login auth: account existence, bans, credential verification; returns the client's `UserAuthenResult` codes; optional `Global Settings.EnforceRevision` gate against `GameRevision` |
| `UserValidator.cs` | Post-auth validation path (session continuity, machine/IP checks) |
| `AuthorityRequester.cs` | Drives the server-authority challenge between client and server |

## For AI Agents

### Working In This Directory
- These are plain static classes taking the `SessionActor` plus a protocol message; they are not actors and have no `Props`.
- Auth result codes are fixed hex values the client understands (`UserAuthenResult`); changing them breaks the client.
- Credential handling touches `Shared/Cryptography` (pass key, session key): keep the handshake in that layer, not here.

### Testing Requirements
No unit tests; verify via the client login flow against the login server (boot the Director, connect a client).

## Dependencies

### Internal
`Shared/Networking` (SessionActor), `Shared/Cryptography`, `WizardData` (accounts, infractions, banned IPs).

### External
Imcodec (proto message types, `Imcodec.Cryptography`).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
