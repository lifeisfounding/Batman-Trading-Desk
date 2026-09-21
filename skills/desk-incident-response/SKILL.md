---
name: desk-incident-response
description: Playbooks for unknown sends, order mismatches, unprotected risk, MCP outages, and suspected misuse on the Batman Trading Desk. Use whenever an execution result is unclear or a control fails.
license: MIT
metadata:
  version: "1.0.0"
  category: desk
---

# Incident response

## Severity

1. Freeze new Robin sends.
2. Lucius: live book and exposure.
3. Robin: reconcile from broker state.
4. Alfred: keep the user informed in plain language.
5. Gordon: journal the timeline; formal review after.

## Unknown send

Do not resend. Query orders/positions by ref_id / order id / symbol window. Report found vs not found. Fresh approval only if placing again.

## Mismatch (filled differently than ticket)

Freeze. Report planned vs actual. User decides flatten / leave / adjust via new ticket.

## MCP / connector outage

Stop writes. Continue research if public data works. Resume only after a read health check and user OK.

## Suspected misuse

User revokes or disconnects agentic trading in Robinhood first. Then investigate. Do not print secrets.
