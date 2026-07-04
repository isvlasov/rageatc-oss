# Perspective: Design Compliance

## What to Examine

### Token Compliance

- **Spacing values:** All spacing values must be multiples of the base unit defined in system.md. Flag any magic numbers.
- **Colour palette:** All colour values must trace back to system.md tokens. Flag hex codes or colour values not in the palette.
- **Border radius:** Must use the radius scale from system.md. Flag inconsistent radius values.
- **Typography:** Font family, sizes, and weights must match system.md scale. Flag deviations.

### Depth Strategy

- **Consistency:** If system.md declares borders-only, there must be no box-shadows on UI elements (except focus rings). If shadows, no borders-as-depth.
- **Elevation hierarchy:** Surface stacking must follow the elevation levels in system.md.

### Pattern Compliance

- **Documented patterns:** If system.md defines a button, card, input, or other pattern, implementations must match the documented measurements (height, padding, radius, font).
- **New patterns:** Components not in system.md are acceptable but should follow the token architecture. Flag components that introduce new tokens not in system.md.

### Design Direction

- **Intent alignment:** Does the implementation feel consistent with the stated personality and foundation? A "precision & density" system with generous padding and soft shadows is a contradiction.
- **Signature presence:** If the design system names a signature element, check whether UI chunks incorporate it.

## Severity Guidance

| Finding | Severity |
|---------|----------|
| Colour value outside system.md palette | Major |
| Spacing value not on the defined grid | Major |
| Mixed depth strategies (shadows in a borders-only system) | Major |
| Documented pattern not followed (wrong height, padding, radius) | Major |
| New component that follows token architecture but is not yet in system.md | Note |
| Radius inconsistency (sharp and soft mixed) | Minor |
| Typography weight or size not in scale | Minor |
| Missing hover/focus/disabled states on interactive elements | Minor |

## Not In Scope

- Whether the design system itself is good (that was approved at Stage 4)
- Marketing or aesthetic opinions ("I would have chosen a different colour")
- Accessibility compliance beyond what system.md specifies (that would be a separate perspective)
