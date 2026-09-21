# Skills

Portable `SKILL.md` skills for the Batman Trading Desk. Grok Bot can save each as a shared skill, or load them as pointers to `/workspace/batman-trading-desk/skills/<name>/SKILL.md`.

## Venue

| Skill | What it teaches | Writes? | Primary users |
| --- | --- | --- | --- |
| [robinhood-mcp](robinhood-mcp/SKILL.md) | Trading MCP read/write map, Agentic-only writes, review-then-place, ref_id, reconciliation | **yes** (Robin only) | everyone (reads); Robin (writes) |

## Desk

| Skill | What it covers | Primary users |
| --- | --- | --- |
| [desk-operating-model](desk-operating-model/SKILL.md) | Roles, Batcave, workspace, evidence, approvals | everyone |
| [desk-trade-lifecycle](desk-trade-lifecycle/SKILL.md) | Seven stages, proposal file, ticket, done criteria | Alfred, everyone |
| [desk-risk-limits](desk-risk-limits/SKILL.md) | Limits interview, sizing arithmetic, PASS/REJECT | Lucius |
| [desk-execution-protocol](desk-execution-protocol/SKILL.md) | Pre-send checklist, single send, unknown results | Robin |
| [desk-monitoring](desk-monitoring/SKILL.md) | Routines, briefs, watches | Alfred, Lucius, Oracle |
| [desk-post-trade-review](desk-post-trade-review/SKILL.md) | Journal, trade/weekly/incident review | Gordon |
| [desk-incident-response](desk-incident-response/SKILL.md) | Unknown sends, mismatches, outages | Robin, Lucius, Alfred |
| [desk-strategy-lab](desk-strategy-lab/SKILL.md) | Rules-first testing; no house strategies | Blake |

## Conventions

- Frontmatter: `name` matches directory, `description` under 1024 characters, `license`, `metadata`.
- No strategy playbooks, no return claims, no real account numbers.
- Every write path names who may use it and under what approval.
