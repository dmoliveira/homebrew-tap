# Maintenance Guide

This document describes the recurring checks that keep this tap reliable.

## Ownership

- Primary owner: `dmoliveira`
- Maintenance actor: repository contributors
- Escalation path: open a GitHub issue in this repository

## Workflow Responsibilities

- `docs-links.yml`
  - Purpose: detect broken Markdown links in `README.md` and `docs/`
  - Cadence: pull request, push to `main`, weekly schedule
  - Action on failure: fix links or update ignore rules in `.github/markdown-link-check.json`

- `asset-guard.yml`
  - Purpose: verify hero asset files and README `<picture>` fallback structure
  - Cadence: pull request, push to `main`, weekly schedule
  - Action on failure: regenerate/fix hero assets and restore README picture block

- `formula-audit.yml`
  - Purpose: run Homebrew style/audit checks for `Formula/sk.rb`
    and verify release highlights freshness
  - Cadence: pull request and push when formula/highlights-related files change
  - Action on failure: fix formula style/audit output
    or run `make release-highlights` and commit

- `pages.yml`
  - Purpose: publish `docs/` to GitHub Pages
  - Cadence: push to `main` when docs or workflow files change, manual dispatch
  - Action on failure: inspect Pages deployment logs and fix docs/workflow configuration

- `generate-hero.yml`
  - Purpose: generate README hero WebP asset using OpenAI image API
  - Cadence: manual trigger and monthly scheduled attempt
  - Action on failure: ensure `OPENAI_API_KEY` exists and rerun workflow

## Local Operator Commands

```bash
make help
make validate
make release-highlights
```

`make validate` is the preferred pre-PR local check.
