# Homebrew Tap Docs 🍺

Welcome to the GitHub Pages docs for `dmoliveira/tap`.

## Support this tap now 💛

If this tap helps your daily workflow, support continued updates:

- Donate now via Stripe: [Support Homebrew Tap](https://buy.stripe.com/8x200i8bSgVe3Vl3g8bfO00)
- Sponsor on GitHub: [@dmoliveira](https://github.com/sponsors/dmoliveira)

## Security Quickstart for Agents (30 seconds) ⚡

- Keep API keys out of prompts, markdown, and notebook outputs.
- Use environment-specific credentials with least privilege.
- Rotate keys periodically and after any suspected exposure.
- Keep CI/artifact logs redacted before sharing publicly.
- Run `make validate` before publishing docs or formula updates.

## Quick Links

- Main README: `../README.md`
- Formula directory: `../Formula/`
- Maintenance guide: `maintenance.md`
- Wiki starter content: `wiki-home.md`
- Support page: `support-the-project.md`
- GitHub wiki: `https://github.com/dmoliveira/homebrew-tap/wiki`
- Latest releases: `https://github.com/dmoliveira/homebrew-tap/releases`

## Install

```bash
brew tap dmoliveira/tap
brew install sk
```

## Formula Catalog

- `sk`: macOS Keychain CLI
- `loopmux`: terminal workflow helper
- `opencode-tmux-mem`: tmux memory helper

## Maintainer Actions

- Refresh release highlights: `make release-highlights`
- Run local checks: `make validate`
- Trigger docs deployment: `https://github.com/dmoliveira/homebrew-tap/actions/workflows/pages.yml`

## Support

- Donate now via Stripe: [Support Homebrew Tap](https://buy.stripe.com/8x200i8bSgVe3Vl3g8bfO00)
- Sponsor on GitHub: [@dmoliveira](https://github.com/sponsors/dmoliveira)

## AI/ML and agent safety concepts

- Principle of least privilege for API keys and service accounts
- Secret minimization in prompts, traces, and telemetry
- Environment isolation between dev, CI, and production
- Fast rotation and revocation procedures for compromised tokens

## Security references

- sk security guide: `https://dmoliveira.github.io/sk/security-for-ai-agents`
- OWASP LLM Top 10: `https://owasp.org/www-project-top-10-for-large-language-model-applications/`
- NIST AI RMF: `https://www.nist.gov/itl/ai-risk-management-framework`
