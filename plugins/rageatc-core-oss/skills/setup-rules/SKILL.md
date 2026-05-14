---
name: setup-rules
description: Symlink all rageatc-oss plugin rules to ~/.claude/rules/ for system prompt loading.
disable-model-invocation: true
---

# Setup Rules

Create symlinks from `~/.claude/rules/` to all rules in every installed rageatc-oss plugin.

## Step 1: Find Installed Plugins

Scan for rules directories across all rageatc-oss plugins:
```
~/.claude/plugins/marketplaces/rageatc-oss/plugins/rageatc-core-oss/rules/
~/.claude/plugins/marketplaces/rageatc-oss/plugins/rageatc-code-oss/rules/
~/.claude/plugins/marketplaces/rageatc-oss/plugins/rageatc-tech-oss/rules/
~/.claude/plugins/marketplaces/rageatc-oss/plugins/rageatc-design-oss/rules/
```

Report which plugins have rules directories.

## Step 2: Ensure Target Directory Exists

```bash
mkdir -p ~/.claude/rules
```

## Step 3: Remove Stale Symlinks

Remove any symlinks in `~/.claude/rules/` that point to rageatc-oss rule files that no longer exist:

```bash
for link in ~/.claude/rules/*.md; do
  if [ -L "$link" ] && [ ! -e "$link" ]; then
    echo "Removing stale: $(basename "$link")"
    rm "$link"
  fi
done
```

## Step 4: Create Symlinks

```bash
for plugin_dir in ~/.claude/plugins/marketplaces/rageatc-oss/plugins/*/rules; do
  if [ -d "$plugin_dir" ]; then
    for f in "$plugin_dir"/*.md; do
      if [ -f "$f" ]; then
        ln -sf "$f" ~/.claude/rules/
        echo "Linked: $(basename "$f") (from $(basename $(dirname $(dirname "$f"))))"
      fi
    done
  fi
done
```

## Step 5: Confirm

List all symlinks in `~/.claude/rules/` and report:
- Number of rules linked
- Rule names and which plugin each comes from

Remind user to restart Claude Code to load the new rules.
