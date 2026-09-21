# Contributing

Batman Trading Desk is instructions and resources for a user's Grok Bot, not software the repository runs. Contributions are prose, prompts and procedures; the bar is accuracy against the live Robinhood Trading MCP and the live Grok Bot product.

## Ground rules

- Original text only (or clearly adapted from the HyperGrok upstream with credit). Do not copy third-party skill prose wholesale. Cite sources in `docs/PROVENANCE.md`.
- No fabricated return claims, live equity figures, real account numbers, or personal secrets anywhere in the repository.
- Every write path stays behind the ticket protocol: Lucius PASS, user approval by id or scoped standing approval, single send, reconciliation. A change that weakens that is a rejected change.
- Never widen write scope beyond the Agentic account.
- Verify MCP tool names against the live connector before changing `robinhood-mcp`.

## Layout

- `agents/<name>.md` — frontmatter (`name`, `title`, `description`, `seat`, `skills`, `writes_to_broker`), a **Bot profile** section (Name, Job, Description) and a **System prompt** section. Display names use **Name (Role)** everywhere.
- `skills/<name>/SKILL.md` — frontmatter (`name` equal to the directory, `description` under 1024 characters, `license`, `metadata`), body kept practical and under ~300 lines where possible.
- `SETUP.md` — the single entry point a Grok Bot follows.

## Checks

```bash
bash scripts/check.sh
```

The check verifies frontmatter, directory/name agreement, description length, internal links and the one-writer rule.
