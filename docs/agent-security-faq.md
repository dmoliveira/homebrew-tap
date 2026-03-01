# Agent Security FAQ

## 1) Why do AI agents increase secret-handling risk?

Agent pipelines often combine prompts, logs, traces, and third-party
integrations. A secret leaked in one layer can spread quickly.

## 2) How do I reduce risk in CI and automation?

Use least-privilege tokens, short credential lifetimes, and strict redaction
in build/test logs before publishing artifacts.

## 3) What should never be committed to docs or formula repos?

Never commit API keys, private tokens, internal credentials, personal access
keys, or copied production traces.

## 4) How do I handle suspected credential exposure?

Revoke immediately, issue replacements, invalidate dependent sessions, and
record remediation steps in incident notes.

## 5) What is the easiest recurring control to keep docs safe?

Run `make validate` before merge and keep a scheduled workflow that checks
links/content freshness and opens PRs when drift is detected.

## Quick companion

- Agent security checklist: `agent-security-checklist.md`
