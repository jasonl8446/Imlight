<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Imlight.Common

## Purpose
The leaf project everything else references: INI configuration access with typed converters, and the Serilog
logging facade. Nothing here depends on CoreLib or Director.

## Key Files

| File | Description |
|------|-------------|
| `ConfigurationManager.cs` | Static INI reader. `Initialize(path)` then `ConfigurationManager.Settings["Section.Key"].AsUShort()` style access; sections and keys are case-insensitive; values parse with invariant culture |
| `Logger.cs` | Static Serilog facade over console, rolling file, and Seq sinks. Logs to `logs/` by default via the `Logging.*` settings; `Logger.Args(...)` named-placeholder pattern is the only sanctioned argument style |

## For AI Agents

### Working In This Directory
- New `.cs` files must carry the full AGPL + section header block (see `.agents/AGENT.md` section 6).
- `Logger`'s static fields read `ConfigurationManager` settings at construction, so configuration must be
  initialized before the first log call; the Director boot order guarantees this. Do not move that dependency the other way.
- Config access is the idiom across the whole repo (`ConfigurationManager.Settings[...].As<Type>()`); keep the converter surface stable before adding a new one.

### Testing Requirements
No tests in the solution. Changes verify by booting the Director (`dotnet run --project src/Imlight.Director`)
and watching the Serilog output in `logs/`.

### Common Patterns
- Static classes, `s_` prefixed static fields, `internal`/`public` explicit.
- `CultureInfo.InvariantCulture` for all numeric parsing; the server runs on machines of any locale.

## Dependencies

### Internal
None. It is the base of the dependency graph.

### External
Serilog (and sinks: console, file, Seq).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
