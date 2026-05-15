#!/bin/bash
# bash-safety-guard.sh
# PreToolUse hook that escalates destructive Bash commands to the permission prompt.
# Fails open: any error (missing jq, bad JSON) allows the command to proceed.

# Check jq is available
if ! command -v jq &>/dev/null; then
  exit 0
fi

# Read JSON from stdin
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null) || exit 0

# Nothing to check
if [[ -z "$COMMAND" ]]; then
  exit 0
fi

# Helper: output ask decision and exit
ask() {
  cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "ask",
    "permissionDecisionReason": "$1"
  }
}
EOF
  exit 0
}

# --- Filesystem destruction ---

# rm with -rf or -fr flags
if echo "$COMMAND" | grep -Eq 'rm\s+.*-[rf]*r[rf]*f|rm\s+.*-[rf]*f[rf]*r'; then
  ask "Detected recursive force delete (rm -rf). Please review."
fi

# mkfs as a command (word boundary)
if echo "$COMMAND" | grep -Ewq 'mkfs'; then
  ask "Detected filesystem format command (mkfs). Please review."
fi

# dd as a command (word boundary)
if echo "$COMMAND" | grep -Ewq 'dd'; then
  ask "Detected raw disk write command (dd). Please review."
fi

# --- Git irreversibility ---

# git push --force (but not --force-with-lease)
if echo "$COMMAND" | grep -Eq 'git\s+push'; then
  if ! echo "$COMMAND" | grep -q 'force-with-lease'; then
    if echo "$COMMAND" | grep -Eq 'git\s+push\s+.*(-f|--force)'; then
      ask "Detected git force push. Please review."
    fi
  fi
fi

# git reset --hard
if echo "$COMMAND" | grep -Eq 'git\s+reset\s+.*--hard'; then
  ask "Detected git reset --hard. Please review."
fi

# git clean -f
if echo "$COMMAND" | grep -Eq 'git\s+clean\s+.*-[a-z]*f'; then
  ask "Detected git clean with force flag. Please review."
fi

# git checkout -- .
if echo "$COMMAND" | grep -Eq 'git\s+checkout\s+--\s+\.'; then
  ask "Detected git checkout -- . (discard all changes). Please review."
fi

# git restore .
if echo "$COMMAND" | grep -Eq 'git\s+restore\s+\.'; then
  ask "Detected git restore . (discard all changes). Please review."
fi

# --- Remote code execution ---

# curl/wget piped to shell
if echo "$COMMAND" | grep -Eq '(curl|wget).*\|\s*(sh|bash|zsh)'; then
  ask "Detected remote code piped to shell. Please review."
fi

# --- System-level ---

# chmod 777
if echo "$COMMAND" | grep -Eq 'chmod\s+777'; then
  ask "Detected chmod 777. Please review."
fi

# sudo rm
if echo "$COMMAND" | grep -Eq 'sudo\s+rm'; then
  ask "Detected sudo rm. Please review."
fi

# No match — allow
exit 0
