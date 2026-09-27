<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# src

## Purpose
The .NET solution (`net10.0`) that is the entire server, in three projects plus the Imcodec submodule
projects referenced from CoreLib.

## Key Files

| File | Description |
|------|-------------|
| `Imlight.sln` | Solution: Imlight.Common, Imlight.CoreLib, Imlight.Director |
| `Imlight.sln.DotSettings` | ReSharper dictionary only; formatting comes from `.editorconfig` and `omnisharp.json` |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `Imlight.Common/` | Configuration (INI) and logging; leaf project everything else references (see `Imlight.Common/AGENTS.md`) |
| `Imlight.CoreLib/` | Everything else: the three servers, all game systems, both data stores (see `Imlight.CoreLib/AGENTS.md`) |
| `Imlight.Director/` | The executable: boot order, Akka system creation, resource discovery, manifests (see `Imlight.Director/AGENTS.md`) |
| `.idea/` | IDE metadata; not source |

## For AI Agents

### Working In This Directory
- Read `.agents/AGENT.md` first: file header template, header rules, comment rules, and the service/zone/Akka idioms all apply here.
- `dotnet` is not on PATH in this environment; it is provided by the user's shell. Verify commands fail cleanly rather than installing a toolchain.

### Testing Requirements
There is no test project in this solution. Verification is `dotnet build src/Imlight.sln`, booting
`Imlight.Director`, and exercising the client.

### Common Patterns
- Project dependency order: Common -> CoreLib -> Director.
- `dotnet format src/Imlight.sln` honors `.editorconfig`; VS Code tasks (`build`, `publish`, `watch`) target Imlight.Director only.
- `bin/` and `obj/` are build output; never edit or commit them.

## Dependencies

### Internal
`submodule/Imcodec` (wire types and IO), the three projects above.

### External
.NET 10 SDK; runtime dependencies are declared per project (Akka.NET, RavenDB, Serilog, Newtonsoft.Json, Nito.*).

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
