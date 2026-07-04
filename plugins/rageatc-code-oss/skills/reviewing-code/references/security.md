# Perspective: Security

## What to Examine

- **Input validation** — is user input sanitised before use? Are types checked?
- **Injection risks** — SQL injection, command injection, path traversal, XSS
- **Authentication and authorisation** — are access controls in place where needed? Are tokens validated?
- **Data exposure** — are secrets, tokens, or sensitive data properly handled? Not logged, not in error messages, not in client responses.
- **Dependency risks** — are new dependencies from trusted sources? Known vulnerabilities?
- **Error messages** — do error responses leak internal details (stack traces, database schemas, file paths)?

## Severity Guidance

| Finding | Severity |
|---------|----------|
| SQL/command injection vulnerability | **Critical** |
| Missing authentication on protected endpoint | **Critical** |
| Secrets in client-facing response or logs | **Critical** |
| Missing input validation on user-facing field | **Major** |
| Dependency with known vulnerability | **Major** |
| Error message leaks internal file path | **Minor** |
| Missing rate limiting (not in brief) | **Note** |

## Key Principle

Security findings are **always at least Major**, even when acceptance criteria are technically met. Security is an implicit acceptance criterion for all code — the developer fixes security issues even if the brief did not require them.
