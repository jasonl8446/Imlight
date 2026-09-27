<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# submodule

## Purpose
Holds the Imcodec git submodule, pinned to `Revive101/Imcodec` main. Imcodec is the source of every wire
type the server speaks: generated message layer, object/property type caches, WAD and IO readers, crypto.
The rest of the repo consumes it through project references, never by copying code.

## Key Files
This directory is a git submodule pointer. The submodule itself is a full repository with its own README,
solution, and tests (see `submodule/Imcodec/`).

## For AI Agents

### Working In This Directory
- Treat the submodule as a read-only pin. Changes belong upstream in the Imcodec repository, not here.
- A clean clone of Imlight will not build until Imcodec's codegen inputs are in place: the wiztype JSON dump
  in `Imcodec.ObjectProperty/GeneratorInput/` and the client `*Messages*.xml` files in
  `Imcodec.MessageLayer/GeneratorInput/`.
- Never hand-roll a protocol or wire struct in `src/`; those types belong to `Imcodec.MessageLayer.Generated`.
- Bumping the submodule commit is a cross-repo decision: confirm with the user before committing a pin change.

### Testing Requirements
`submodule/Imcodec/` carries its own test projects (`test/*`); build them in the Imcodec context, not the
Imlight one.

## Dependencies

### Internal
None from Imlight. It is the dependency root.

### External
`Revive101/Imcodec` (upstream of the pin), .NET SDK.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
