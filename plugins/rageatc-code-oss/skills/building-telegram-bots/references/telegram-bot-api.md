# Telegram Bot API Reference

*Last verified: 2026-07-04. Fetch the canonical URLs below to confirm current state.*

## Current Bot API Version

**Bot API 10.1** — released 2026-06-11

Fetch `https://core.telegram.org/bots/api#recent-changes` to confirm the current version before answering any question about API feature availability.

## Page Structure and Anchors

All Bot API documentation lives on a single page, `https://core.telegram.org/bots/api` — navigate by anchor; all method and type definitions are inline.

| Section | URL |
|---------|-----|
| Recent changes (changelog) | `https://core.telegram.org/bots/api#recent-changes` |
| Making requests | `https://core.telegram.org/bots/api#making-requests` |
| Getting updates | `https://core.telegram.org/bots/api#getting-updates` |
| Available types | `https://core.telegram.org/bots/api#available-types` |
| Available methods | `https://core.telegram.org/bots/api#available-methods` |
| Sending files | `https://core.telegram.org/bots/api#sending-files` |
| Individual method | `https://core.telegram.org/bots/api#{methodname}` — e.g., `#sendmessage` |
| Individual type | `https://core.telegram.org/bots/api#{typename}` — e.g., `#message` |

## Supplementary Official Pages

| Resource | URL |
|----------|-----|
| Bots overview | `https://core.telegram.org/bots` |
| Webhook guide | `https://core.telegram.org/bots/webhooks` |
| FAQ (rate limits, common questions) | `https://core.telegram.org/bots/faq` |
| Bot features guide | `https://core.telegram.org/bots/features` |
| Tutorial (BotFather to Hello World) | `https://core.telegram.org/bots/tutorial` |
| Code examples | `https://core.telegram.org/bots/samples` |

## Operational Limits

### Rate Limits

| Limit | Value |
|-------|-------|
| Per-chat message rate | 1 message/second (short bursts permitted) |
| Per-group rate | 20 messages/minute |
| Bulk broadcast rate | ~30 messages/second across all chats |
| 429 response field | `retry_after` — seconds to wait before retrying |

**Source:** `https://core.telegram.org/bots/faq`

The only correct response to a 429 is to wait exactly `retry_after` seconds, then retry. Never retry immediately.

### File Size Limits

| Operation | Standard server | Local Bot API server |
|-----------|----------------|----------------------|
| Download via `getFile` | Up to 20 MB | Up to 2,000 MB |
| Upload via `sendDocument` etc. | Up to 50 MB | Up to 2,000 MB |

**Source:** `https://core.telegram.org/bots/api#sending-files`

File download URL pattern (not explicitly documented on the API page):
```
https://api.telegram.org/file/bot{TOKEN}/{file_path}
```
where `file_path` is the value returned by `getFile`.

The `file_size` field can exceed 2^31 — handle as a 64-bit integer.

## Webhook vs Polling

Webhook (`setWebhook`) constraints, per `https://core.telegram.org/bots/webhooks`:

- Requires HTTPS with valid certificate (TLS 1.2+)
- Supported ports: 443, 80, 88, 8443
- Self-signed certificates supported via the `certificate` parameter

### Webhook Storm Prevention

When a webhook handler sends a reply and hits a 429 rate limit, Telegram retries the update — triggering the handler again, causing another 429. The correct pattern:

1. Acknowledge the webhook immediately with HTTP 200
2. Queue all outbound messages to a background worker
3. Let the worker respect `retry_after` on 429 responses

**Source:** `https://grammy.dev/advanced/flood`

## Recent Version History

*Fetch `https://core.telegram.org/bots/api#recent-changes` to verify current state.*

| Version | Date | Key additions |
|---------|------|---------------|
| Bot API 10.1 | 2026-06-11 | Rich Messages formatting classes; join request queries; polls with media and multiple correct answers |
| Bot API 10.0 | 2026-05-08 | Guest Mode (messages from unjoined chats); reaction deletion methods; Live Photos |
| Bot API 9.6 | 2026-04-03 | Managed Bots (bots creating/controlling bots); multi-answer quizzes; poll option add/delete tracking |
| Bot API 9.5 | 2026-03-01 | `date_time` MessageEntity type; `setChatMemberTag` method; custom emoji for WebApp bottom buttons |
