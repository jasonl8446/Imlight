<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Shared/Structures

## Purpose
Small generic data structures used across the servers.

## Key Files

| File | Description |
|------|-------------|
| `Cache.cs` | A simple cached lookup wrapper |
| `ListQueue.cs` | A list backed by a queue for FIFO consumption |
| `ObservableHashSet.cs` | A `HashSet` with change observation |

## For AI Agents

### Working In This Directory
- These are internal helpers with no protocol surface; extend them narrowly when a feature needs the same
  shape, and prefer the existing type over a new collection in `Game/`.
- Thread safety is the consumer's contract here: document (not enforce) expectations if you add a type.

### Testing Requirements
No unit tests. Exercise the consuming feature in a client.

## Dependencies

### Internal
`Imlight.Common` (where logging/config are needed).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
