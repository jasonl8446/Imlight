<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Shared/Resources

## Purpose
Content access for the server: WAD archive loading and caching, core object construction from templates,
the name bank and locale data, and the `Root*Singleton` bases that the Director's `ResourceContainer`
discovers by reflection at boot.

## Key Files

| File | Description |
|------|-------------|
| `ResourceManager.cs` | Central resource lookup |
| `RootArchiveLoader.cs` | Loads WAD archive data (the resource surface for `RootDirectoryResourceSingleton` consumers) |
| `LocalWadCache.cs` | Locally cached WAD data |
| `BehaviorCache.cs` | Cache of behavior data loaded from resources |
| `CoreObjectFactory.cs` | Builds `CoreObject`s from templates (used by entities, behaviors, loaders) |
| `RootSingleResourceSingleton.cs` / `RootDirectoryResourceSingleton.cs` | The two discovery bases: `ResourceContainer` instantiates and calls `Initialize()` on every derivation (see `Imlight.Director/ResourceContainer`) |
| `PatchServerFascade.cs` | Facade that routes missing-resource fetches through the patch server (the BYOD hook) |
| `CharacterNameBank.cs` | Character name pool |
| `Locale.cs` | Locale handling for game strings |
| `IMemoryStreamDisposable.cs` / `Util.cs` | Stream and misc helpers |

## For AI Agents

### Working In This Directory
- To make a new boot-time resource, derive it from `RootSingleResourceSingleton<>` or `RootDirectoryResourceSingleton<>`; that is both the declaration and the registration (the Director discovers it by base type).
- Missing content should flow through `PatchServerFascade` (download then cache), not through ad-hoc HTTP.
- Object construction goes through `CoreObjectFactory`; do not hand-build `CoreObject`s from raw fields elsewhere.
- The caches here are process-lifetime; they are populated at boot and expected to be stable after.

### Testing Requirements
No unit tests. Verify by booting the Director (resource init logged) and using the feature that consumes
the content (item spawn, name, string).

## Dependencies

### Internal
`Imlight.Common`, `Patch` (facade target), `Imlight.Director` (discovery consumer).

### External
Imcodec (WAD IO, types), Newtonsoft.Json.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
