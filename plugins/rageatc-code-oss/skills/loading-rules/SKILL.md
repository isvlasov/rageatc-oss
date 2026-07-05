---
name: loading-rules
description: Loads the rageatc-code-oss operating rules directly from the plugin when the SessionStart hook has not delivered them. Use when the rageatc-code-oss failsafe line appears in session-start hook output, when the plugin's operating rules are absent from context, or when the injected rules look truncated.
---

# Loading Rules

The rageatc-code-oss operating rules normally arrive via a SessionStart hook. If that failed or was truncated, recover them:

1. Read every `.md` file in `../../rules/` (relative to this skill's base directory).
2. Follow them as binding operating rules for the rest of the session.
