# Installation

Setup for rageatc-oss.

## Before you start

You need Claude Code or Claude Cowork installed.

All commands below are typed inside a Claude Code or Cowork session, not in your terminal.

## 1. Add the marketplace

```
/plugin marketplace add isvlasov/rageatc-oss
```

This tells Claude where to find the plugins. You only do this once.

## 2. Install the plugins

Install whichever ones you want — they work alone or together.

```
/plugin install rageatc-core-oss@rageatc-oss
```

```
/plugin install rageatc-tech-oss@rageatc-oss
```

```
/plugin install rageatc-code-oss@rageatc-oss
```

```
/plugin install rageatc-design-oss@rageatc-oss
```

## Updating

To get the latest version of a plugin:

```
/plugin update rageatc-core-oss@rageatc-oss
```

```
/plugin update rageatc-tech-oss@rageatc-oss
```

```
/plugin update rageatc-code-oss@rageatc-oss
```

```
/plugin update rageatc-design-oss@rageatc-oss
```

By default Claude doesn't auto-update plugins from third-party marketplaces. If you want it to, see below.

## Optional: enable auto-updates

Open your Claude settings file at `~/.claude/settings.json` (create it if it doesn't exist) and add this:

```json
{
  "env": {
    "FORCE_AUTOUPDATE_PLUGINS": "1"
  }
}
```

If you already have other settings in the file, add the `env` block alongside them.

Restart Claude for the change to take effect.
