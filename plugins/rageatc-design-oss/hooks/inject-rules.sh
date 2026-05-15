#!/bin/bash
# rageatc rules injector — SessionStart hook
# Reads ${CLAUDE_PLUGIN_ROOT}/rules/*.md and injects them as additionalContext.
# Skips resume events (rules already in context). Fires on startup, clear, compact.
# No-ops silently if rules/ is missing or empty.

set -e

event_source=$(jq -r '.source // "startup"')
[ "$event_source" = "resume" ] && exit 0

rules_dir="${CLAUDE_PLUGIN_ROOT}/rules"
[ -d "$rules_dir" ] || exit 0

shopt -s nullglob
files=("$rules_dir"/*.md)
[ ${#files[@]} -eq 0 ] && exit 0

plugin_name="${CLAUDE_PLUGIN_ROOT##*/}"

content="The following are operating rules for the \`${plugin_name}\` plugin. Read carefully and follow them throughout this session.

"
for f in "${files[@]}"; do
  content+="## ${f##*/}

$(cat "$f")

"
done

jq -n --arg ctx "$content" '{hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: $ctx}}'
