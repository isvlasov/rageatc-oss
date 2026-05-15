# Craft in Action

This shows how the subtle layering principle translates to real decisions. Learn the thinking, not the code. Your values will differ — the approach will not.

---

## The Subtle Layering Mindset

Before looking at any example, internalise this: **you should barely notice the system working.**

When you look at Vercel's dashboard, you do not think "nice borders." You just understand the structure. When you look at Supabase, you do not think "good surface elevation." You just know what is above what. The craft is invisible — that is how you know it is working.

---

## Example: Dashboard with Sidebar and Dropdown

### The Surface Decisions

**Why so subtle?** Each elevation jump should be only a few percentage points of lightness. You can barely see the difference in isolation. But when surfaces stack, the hierarchy emerges. This is the Vercel/Supabase way — whisper-quiet shifts that you feel rather than see.

**What NOT to do:** Do not make dramatic jumps between elevations. That is jarring. Do not use different hues for different levels. Keep the same hue, shift only lightness.

### The Border Decisions

**Why rgba, not solid colours?** Low opacity borders blend with their background. A low-opacity white border on a dark surface is barely there — it defines the edge without demanding attention. Solid hex borders look harsh in comparison.

**The test:** Look at your interface from arm's length. If borders are the first thing you notice, reduce opacity. If you cannot find where regions end, increase slightly.

### The Sidebar Decision

**Why same background as canvas, not different?**

Many dashboards make the sidebar a different colour. This fragments the visual space — now you have "sidebar world" and "content world."

Better: Same background, subtle border separation. The sidebar is part of the app, not a separate region. Vercel does this. Supabase does this. The border is enough.

### The Dropdown Decision

**Why surface-200, not surface-100?**

The dropdown floats above the card it emerged from. If both were surface-100, the dropdown would blend into the card — you would lose the sense of layering. Surface-200 is just light enough to feel "above" without being dramatically different.

**Why border-overlay instead of border-default?**

Overlays (dropdowns, popovers) often need slightly more definition because they are floating in space. A touch more border opacity helps them feel contained without being harsh.

---

## Example: Form Controls

### Input Background Decision

**Why darker, not lighter?**

Inputs are "inset" — they receive content, they do not project it. A slightly darker background signals "type here" without needing heavy borders. This is the alternative-background principle.

### Focus State Decision

**Why subtle focus states?**

Focus needs to be visible, but you do not need a glowing ring or dramatic colour. A noticeable increase in border opacity is enough for a clear state change. Subtle-but-noticeable — the same principle as surfaces.

---

## Adapt to Context

Your product might need:
- Warmer hues (slight yellow/orange tint)
- Cooler hues (blue-gray base)
- Different lightness progression
- Light mode (principles invert — higher elevation = shadow, not lightness)

**The principle is constant:** barely different, still distinguishable. The values adapt to context.

---

## The Craft Check

Apply the squint test to your work:

1. Blur your eyes or step back
2. Can you still perceive hierarchy?
3. Is anything jumping out at you?
4. Can you tell where regions begin and end?

If hierarchy is visible and nothing is harsh — the subtle layering is working.
