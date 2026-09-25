# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Read this first

`.agents/AGENT.md` is the authoritative operating guide for this repo (code style, the mandatory
file-header template, comment rules, architecture idioms, commit conventions). Read it before
writing or editing any `.cs` file. Its own rule applies: **if a rule and the tree disagree, the
tree wins.**

The two rules most often violated by a first-time contributor:

- **Every `.cs` file in `src/` opens with the AGPL banner plus a structured section block**
  (`PURPOSE:` / `USAGE EXAMPLE:` / `NOTE:` / `TODO:` / `Created by:` / `Version: KALI 1.0` /
  `Last Updated: MM/DD/YYYY`). Copy the exact shape from a neighbouring file. `Created by:` is
  never rewritten; `Last Updated:` is bumped on substantive edits. AI-assisted files credit the
  agent and exact model alongside the human author.
- **Comments never narrate a fix or a workaround.** `// todo:` means uncertainty, not assignment.
  No comment directly above a method signature unless it is a `///` summary.

## Commands

The solution lives in `src/`. Target framework is `net10.0`.

```bash
dotnet build src/Imlight.sln
dotnet run   --project src/Imlight.Director          # boots the whole server
dotnet watch run --project src/Imlight.Director
dotnet format src/Imlight.sln                        # honours .editorconfig
```

`dotnet` is not on PATH in this environment; it must be provided by the user's own shell/dev
environment. VS Code tasks (`build`, `publish`, `watch`) target `Imlight.Director` only.

There is **no test project**: nothing in the solution to run. Verification is done by booting the
Director and exercising the client.

Docs (VitePress, deployed from `quality-assurance` by `.github/workflows/deploy-docs.yml`):

```bash
cd docs && npm install && npm run docs:dev      # docs:build / docs:preview
```

### Submodule

`submodule/Imcodec` (pinned to `Revive101/Imcodec` main) generates all wire types at compile time
from inputs that are **not** committed. A clean clone will not build until those inputs are placed:

- a wiztype type-dump JSON in `submodule/Imcodec/src/Imcodec.ObjectProperty/GeneratorInput/`
- the client's `*Messages*.xml` definitions in `submodule/Imcodec/src/Imcodec.MessageLayer/GeneratorInput/`

Never hand-roll a protocol struct; it belongs in `Imcodec.MessageLayer.Generated`.

## Architecture

Three projects:

- `Imlight.Common` provides `ConfigurationManager` (reads `Config/Imlight.ini`, accessed as
  `ConfigurationManager.Settings["Section.Key"].AsUShort()`) and `Logger` (Serilog).
- `Imlight.CoreLib` holds everything else: the three servers, game systems, and data layer.
- `Imlight.Director` is the executable. It boots in a fixed order: config, then the Akka system
  (`Config/akka.conf`), then the **patch server first** (so missing resources can be fetched),
  then `ResourceContainer`, the login server, N game servers (one per realm), and the RavenDB store.
  Then it idles forever.

### Actors and message dispatch

Everything is Akka.NET. The load-bearing abstraction is `Shared/Networking/ReceiveProtocolDispatcher`:
it reflects over its own methods at construction and builds a `Type -> MethodInfo` map from
`[MessageHandler(typeof(SOME_PROTOCOL.MSG_X))]` attributes. `Server`, `Zone`, and `MessageService`
all derive from it, so protocol handling everywhere is "tag a method with the message type".

A connection is a `SessionActor`. A `ServiceFactory` subclass (`LoginServiceFactory`,
`GameServiceFactory`, `PatchServiceFactory`) declares a `HashSet<Type> ServiceTypes` of the
`MessageService`s automatically attached to each session joining that server. **Adding a new
service means registering it in the relevant factory**; nothing else wires it up.

Inside a service: handlers are private, reach the player via `GetActiveWizard()`, reply via
`SendToSocket(...)`, and expose a `protected static Props(...)` factory. Cross-server coordination
uses `SERVER_100_PROTOCOL.*` messages (e.g. the Director asks the login server to spawn game
servers).

### Zones and entities

`Game/Zone/Core/Zone.cs` is an actor per loaded zone; it delegates to supervisors
(`ZoneEntitySupervisor`, `ZonePlayerSupervisor`, `ZoneObjectSupervisor`, path/trigger/volume/sigil).
A `ZoneEntity` is a bag of `ZoneEntityComponent`s: behaviour is composed, not inherited. A new
behaviour is a `Game/Zone/Components/XComponent(ZoneEntity entity) : ZoneEntityComponent(entity)`
implementing `IComponentFactory` (plus `IServiceComponent` with `ServiceName`/`NpcIcon` if the
player can interact with it); `ZoneEntityComponentRegistry` resolves them. `GameWorld` /
`InstanceContainer` own zone instancing and dungeons.

Two other dispatcher-style subsystems follow the same registry shape: `Game/Requirements`
(gating, `RequirementDispatcher` + `Handlers/` + `Contexts/`) and `Game/Results`
(effects of quests/interactions, `ResultDispatcher` + `ResultExecutorActor`).

### Data: two distinct stores

- **Player-generated data lives in RavenDB.** `WizardData/`. `RavenDatabaseSingleton<T>` is the lazy
  singleton base; `PlayerDatabase.Instance.Store` is the entry point; `WizardData/Collections/*`
  are the per-document-type accessors. With no remote URL configured, an embedded instance is
  spooled up (`EmbeddedDatabaseManager`) and an admin account is seeded from `Imlight.ini`.
- **Static world data comes from SpiralDB.** `WizardData/SpiralDB.cs` is a static in-memory store
  (concurrent dictionaries of quest templates, drop tables, NPC inventories, creature spellbooks,
  zone data) fetched from the `spiraldb` GitHub repo on boot or read from `spiraldb-cache/`.
  No database involved. Missing content here, not missing code, is why the README marks some
  features with `*`.

Client-side object state is mirrored by `Shared/Behaviors/Server*Behavior.cs` classes, which map
onto the client's own behavior objects.

## Conventions that affect PRs

- Mainline branch is `quality-assurance`; feature branches merge into it.
- Conventional commits (`feat:`, `fix:`, `ref:`, `chore:`, `docs:`); milestone commits use
  `KALI 26Q2.14c | Feature (#NN)`.
- One item, one PR. No drive-by reformatting or unrelated using-order churn.
- `CONTRIBUTING.md` **requires disclosure of AI assistance** in the issue/PR template, and holds
  the submitter responsible for explaining the change in their own words.
- No em dashes in comments, headers, docs, or commit messages.
