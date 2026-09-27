<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Shared/Cryptography

## Purpose
The client handshake primitives: pass key / session key / client key exchange, the REC1 challenge step,
and CRC-32. Everything login-authentication touches on the wire is here.

## Key Files

| File | Description |
|------|-------------|
| `PassKey3.cs` | The pass key exchange step (the "3" is the protocol's key version) |
| `SessionKey.cs` | The per-session key derived during auth |
| `ClientKey.cs` | The client-side key material handling |
| `Rec1.cs` | The REC1 challenge/response leg |
| `Crc32.cs` | CRC-32 used by the handshake and file integrity paths |

## For AI Agents

### Working In This Directory
- The order of the handshake is client-visible; `Auth/UserAuthenticator` and `Auth/AuthorityRequester` call into this layer. Do not change key sizes, derivation, or ordering without a matching client change.
- This layer is shared by the login server (auth) and the patch server (`LatestFileList` keys), so keep both call sites compiling and passing after any signature change.
- Use the existing primitives; do not add a new crypto scheme for a new use case.

### Testing Requirements
No unit tests. Verify by completing a real client login (the full handshake) and a patch list fetch.

## Dependencies

### Internal
Consumed by `Auth/`, `Patch/`, `Login/`. `Imlight.Common`.

### External
.NET crypto APIs, BouncyCastle (where referenced).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
