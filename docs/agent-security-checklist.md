# AI Agent Security Checklist

A compact operational checklist for maintainers and automation users.

## Before running agents or CI

- Use environment-specific credentials with least privilege.
- Keep secrets out of prompts, docs, and commit messages.
- Prefer runtime secret injection instead of static files.

## During execution

- Redact logs and traces before publishing artifacts.
- Avoid exposing internal endpoints, tokens, or user identifiers.
- Keep tool outputs scoped to the minimum needed context.

## Before docs/formula release

- Run `make validate` and inspect changed files manually.
- Confirm Pages and release links are correct and public-safe.
- Verify no secret-like values appear in generated content.

## If exposure is suspected

- Revoke and replace credentials immediately.
- Rotate related keys and tokens in dependent systems.
- Document remediation steps and follow-up controls.

## Copy/paste secure setup snippets

### Local shell pattern

```bash
# Export runtime secret only for current process tree
export OPENAI_API_KEY="$(sk get -k OPENAI_API_KEY)"
run_your_agent_command
unset OPENAI_API_KEY
```

### CI job pattern

```yaml
- name: Use runtime credential
  run: |
    export OPENAI_API_KEY="${{ secrets.OPENAI_API_KEY }}"
    run_your_pipeline_here
```

### Pre-release safety check

```bash
make validate
```
