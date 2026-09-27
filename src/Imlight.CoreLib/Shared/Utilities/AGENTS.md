<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Shared/Utilities

## Purpose
Two utility helpers: data manipulation on client-shaped buffers, and the shared random generator.

## Key Files

| File | Description |
|------|-------------|
| `DataManipulation.cs` | Read/write helpers over raw buffer data (byte order, typed reads) |
| `RandomGen.cs` | The server's shared random source (use for game RNG instead of ad-hoc `new Random()`) |

## For AI Agents

### Working In This Directory
- Use `RandomGen` for any in-game random decision (drops, duels, spawns); a per-call `new Random(0)`
  pattern or unseeded `Random` in a hot path is a known correctness hazard the repo avoids.
- Buffer work should stay byte-order explicit (InvariantCulture / little-endian as the client expects).

### Testing Requirements
No unit tests. Verify the feature that uses the RNG or the buffer (e.g. drop rolls, packet fields) in-game.

## Dependencies

### Internal
`Imlight.Common`.

### External
.NET BCL only.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
