<!-- Parent: ../AGENTS.md -->
<!-- Generated: 2026-09-27 | Updated: 2026-09-27 -->

# Shared/Items

## Purpose
Item-side helpers: item construction/normalization, the dye color mapping, and price modifiers used by
shops and the economy.

## Key Files

| File | Description |
|------|-------------|
| `ItemHelper.cs` | Item object helpers used by inventory, shop, and drop paths |
| `DyeMapper.cs` | Dye color id mappings (client dye palette <-> server) |
| `PriceModifiersConfig.cs` | Price modifier settings from configuration (merchant pricing) |

## For AI Agents

### Working In This Directory
- Dyed items are identified by the client through the `DyeMapper` mapping; a wrong mapping shows the wrong
  color in-game, so verify dyes visually.
- Pricing should flow through `PriceModifiersConfig`; do not bake prices into shop handlers.

### Testing Requirements
No unit tests. Verify with a client: buy/dye an item and check the color and the price.

## Dependencies

### Internal
`Imlight.Common`, `Shared/Behaviors` (inventory), Imcodec item types.

<!-- MANUAL: Any manually added notes below this line are preserved on regeneration -->
