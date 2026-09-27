<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Patch

## Purpose
Patch infrastructure, the BYOD half of the project: fetch the `LatestFileList` from the configured remote
patch endpoint, serve file-list metadata to connecting clients, and download individual WAD archives on
demand so the server itself can patch missing resources at boot.

## Key Files

| File | Description |
|------|-------------|
| `PatchServer.cs` | Singleton actor (a `Server`): `MSG_INITIALIZE` triggers the endpoint check and file-list cache (blocking); exposes `Instance` and `EndpointReached`; singleton guard throws on a second instance |
| `LatestFileList.cs` | The file-list model parsed from `LatestFileList.bin` / `.xml` |
| `PatchServiceFactory.cs` | Declares the single `PatchService` attached to patch sessions |
| `Services/PatchService.cs` | The client-facing protocol service for the PATCH protocol (file list and download requests) |

## For AI Agents

### Working In This Directory
- Boot order depends on this server starting first (see `../../Imlight.Director/AGENTS.md`): it must be reachable before any resource loads, so missing WADs can be fetched through it.
- The working URL is built as `Data/GameData` under the configured `Patch Server.PatchServerInternalUrl`; the `Advanced.PatchServerUserAgent` and buffer size settings are honored.
- `Patch/Services/` holds exactly one service; keep the one-service-per-protocol naming when adding another.

### Testing Requirements
No unit tests. Verify by booting the Director with a configured remote endpoint and watching the patch log
and the client's patch flow.

## Dependencies

### Internal
`Shared/Networking`, `Shared/Packets` (PATCH_105, SERVER_100), `Shared/Cryptography` (file list keys), `Imlight.Common`.

### External
HTTP client, Imcodec.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
