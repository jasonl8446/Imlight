<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Requirements/Contexts

## Purpose
The data a requirement handler may see, scoped per evaluation site. Handlers only touch the context
interface, never raw actors or databases.

## Key Files

| File | Description |
|------|-------------|
| `GenericRequirementContext.cs` | The minimal context: player actor ref + player object |
| `QuestRequirementContext.cs` | Adds quest name and quest instance state (offer/turn-in gating) |
| `ZoneRequirementContext.cs` | Adds the zone actor and zone data (zone entry and trigger gating) |

## For AI Agents

### Working In This Directory
- Subclass the narrowest existing context instead of a new one; a context exists per evaluation shape, not per feature.
- Contexts are constructed at the call site and passed into `RequirementDispatcher.EvaluateRequirements`; do not cache them.

### Testing Requirements
No unit tests. Verify via the feature that evaluates the requirement (quest offer, zone entry) in a client.

## Dependencies

### Internal
`IRequirementContext` contract, `WizardData` (player models, zone data), Akka refs.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
