<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Imlight

## Purpose
Imlight is an independent Wizard101 private server (the Revive101 line), written entirely in C# for a modern
client (target `net10.0`). Philosophy is BYOD: the server ships no copyrighted game data. World content
(quest templates, drops, NPC inventories, zone data) comes from SpiralDB, assets come from the client WADs,
and the server itself is the framework: patch, login, and game servers, zones, combat, and player data.

## Key Files

| File | Description |
|------|-------------|
| `CLAUDE.md` | Contributor guide; points at `.agents/AGENT.md` as the authoritative operating rules |
| `README.md` | Project overview; `*` marked features are content-gated, not code-gated |
| `CONTRIBUTING.md` | Contribution rules, including mandatory AI-assistance disclosure |
| `LICENSE` | AGPL-3.0 |
| `.editorconfig` | `dotnet format` rules (known conflict with the tree on `else`/`catch` newlines, see AGENT.md section 10) |
| `omnisharp.json` | IDE formatting; the tree matches this file over `.editorconfig` |
| `backup-db.sh` | Cold backup of the embedded player database; Director must be stopped first |
| `wizard-city-quests.csv` | Quest name mapping table used for content naming |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `.agents/` | Agent operating guide, the ruleset every AGENTS.md references (see `.agents/AGENTS.md`) |
| `.github/` | CI (docs deploy), issue/PR templates, dependabot (see `.github/AGENTS.md`) |
| `src/` | The .NET solution: Common, CoreLib, Director (see `src/AGENTS.md`) |
| `docs/` | VitePress documentation book (see `docs/AGENTS.md`) |
| `submodule/` | Imcodec git submodule, source of all wire types (see `submodule/AGENTS.md`) |
| `spiraldb-cache/` | Local cache of static world data (quest templates, drop tables, inventories, zone transfer). Treated as data, not code |
| `logs/` | Serilog rolling daily output; runtime artifact |
| `cache/` | Scratch area; empty in a clean checkout |

## For AI Agents

### Working In This Directory
- Read `.agents/AGENT.md` before touching any `.cs` file. If a rule and the tree disagree, the tree wins; update the file, do not churn code.
- Push policy (user standing instruction): git pushes go only to `origin` (`jasonl8446/Imlight`, the user's fork). Never push to `upstream` (`Revive101/Imlight`) or any other remote unless the user names it in that moment.
- `dotnet` is not on PATH in this environment; it lives in the user's shell. Do not attempt to install it.
- Every new `.cs` file carries the full AGPL banner plus `PURPOSE/USAGE EXAMPLE/NOTE/TODO/Created by/Version/Last Updated`. `Created by:` is never rewritten; AI contribution is credited with agent name and exact model.
- No em dashes in any prose you author (headers, docs, comments, commit messages).

### Testing Requirements
- There is no test project. Verification: `dotnet build src/Imlight.sln`, boot the Director with
  `dotnet run --project src/Imlight.Director`, and exercise the client.

### Common Patterns
- Conventional commits (`feat:`/`fix:`/`ref:`/`chore:`/`docs:`); feature branches merge into `quality-assurance`; one item per PR.
- Major version ladder: PROTO (proto/early networking) -> NETHRA (playable) -> KALI (current, feature-complete push).

## Dependencies

### Internal
The three projects under `src/`; each has its own AGENTS.md.

### External
- Akka.NET (actors), RavenDB (player data), Serilog (logging), Newtonsoft.Json, Nito.*, LiteDB
- Imcodec submodule (wire types, generated code)
- SpiralDB repository (world content), client WADs (assets)

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
