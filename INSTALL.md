# Installation

Setup for rageatc-oss.

## Before you start

You need Claude Code (desktop app or terminal) or Claude Cowork (app) installed.

## Install through the desktop app

Works for Claude Code (desktop) and Cowork.

1. Press **Customize**.
2. Under **Personal plugins**, choose **Create plugin**.
3. Choose **Add marketplace** and point it at `isvlasov/rageatc-oss`.
4. All four `rageatc-*-oss` plugins appear in the list. Install whichever ones you want.

## Install with commands

The commands below are typed inside a Claude Code or Cowork session, not in your terminal.

### 1. Add the marketplace

```
/plugin marketplace add isvlasov/rageatc-oss
```

This tells Claude where to find the plugins. You only do this once.

### 2. Install the plugins

Install whichever ones you want. They work alone or together.

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

## Optional: enable auto-updates

Auto-updates are off by default for third-party marketplaces like this one. Turn them on per marketplace from the plugin manager:

1. Run `/plugin` to open the plugin manager.
2. Go to the **Marketplaces** tab.
3. Select `rageatc-oss`.
4. Choose **Enable auto-update**.

From then on, Claude refreshes the marketplace and updates installed plugins at startup. If anything updated, you'll see a prompt to run `/reload-plugins`.
