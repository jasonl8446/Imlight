<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# docs

## Purpose
The project's VitePress documentation book. Two volumes: the main book under `docs/modules/imlight/`
(concepts, game server, login server, wizard data) and protocol internals under `docs/modules/internals/`
(auth, schemas, and the DML / KINP / OP wire systems). Deployed from `quality-assurance` by
`.github/workflows/deploy-docs.yml`.

## Key Files

| File | Description |
|------|-------------|
| `package.json` | VitePress dependency and scripts (`docs:dev`, `docs:build`, `docs:preview`) |
| `spiraldb-reference.md` | Reference notes on the SpiralDB repository content |

## Subdirectories

| Directory | Purpose |
|-----------|---------|
| `docs/modules/imlight/` | Main book. `concepts/` (actor fundamentals, session actor, message handling, message services, player architecture, shared data, imcodec), `gameserver/` (gameserver, zone architecture, zone components, combat, commands), `loginserver/` (server, auth flow, server discovery), `wizarddata/`, `commands.md`, `quickstart.md`, `todo.md` (see the pages themselves) |
| `docs/modules/internals/` | Wire internals for advanced contributors: `auth/`, `launchargs.md`, `schemas.md`, `systems/dml/` (protocols, records, serialization), `systems/kinp/` (packet framing, session, control messages), `systems/op/` (core object, property class, serialization) |
| `docs/.vitepress/` | Site config (`config.mts`) and minimal theme (`custom.css`, `index.js`). `cache/` is build output: never edit, never commit |
| `docs/modules/images/` | Book illustrations (PNG) |

## For AI Agents

### Working In This Directory
- Docs are markdown plus VitePress config; there is no doc test suite. Verify with `docs:preview` if a browser is available.
- Keep doc claims consistent with `src/` and `.agents/AGENT.md`; where a page describes server behavior, the code is the source of truth.
- Do not commit `docs/.vitepress/cache/` or `node_modules/`.

### Testing Requirements
`npm install`, then `npm run docs:dev` (or `docs:build` for a strict build check).

### Common Patterns
- One concern per page; `index.md` per section is the landing page.
- The `internals/` volume documents protocol layers by letter code (DML, KINP, OP); match the existing naming.

## Dependencies

### Internal
Reads from `src/` (described behavior) and `.agents/AGENT.md` (rules).

### External
VitePress (docs), Node.js.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
