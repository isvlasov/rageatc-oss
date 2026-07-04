# Craft in Action

How the subtle layering principle translates to real decisions. Learn the thinking, not the code — your values will differ; the approach will not.

## Dashboard: Sidebar and Dropdown

**Borders — why rgba, not solid colours?** Low-opacity borders blend with their background: they define the edge without demanding attention. Solid hex borders look harsh in comparison. The test: look from arm's length — if borders are the first thing you notice, reduce opacity; if you cannot find where regions end, increase slightly.

**Sidebar — why the same background as the canvas?** A different colour fragments the visual space into "sidebar world" and "content world". Same background with subtle border separation keeps the sidebar part of the app, not a separate region. Vercel does this. Supabase does this. The border is enough.

**Dropdown — why surface-200, not surface-100?** The dropdown floats above the card it emerged from. If both were surface-100, the dropdown would blend into the card — the sense of layering would vanish. One level up is just light enough to feel "above" without being dramatically different.

**Why border-overlay instead of border-default?** Overlays (dropdowns, popovers) float in space and need slightly more definition. A touch more border opacity helps them feel contained without being harsh.

## Form Controls

**Input background — why darker, not lighter?** Inputs are inset — they receive content, they do not project it. A slightly darker background signals "type here" without heavy borders. This is the alternative-background principle.

**Focus state — why subtle?** Focus must be visible, but not a glowing ring or dramatic colour. A noticeable increase in border opacity is a clear state change. Subtle-but-noticeable — the same principle as surfaces.

## Adapt to Context

Your product might need warmer hues, cooler hues, a different lightness progression, or light mode (where the principles invert — higher elevation via shadow, not lightness). The values adapt; the principle is constant: barely different, still distinguishable.
