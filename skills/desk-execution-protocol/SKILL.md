---
name: desk-execution-protocol
description: Robin's procedure for turning an approved ticket into one Robinhood MCP write and reconciling it - pre-send checklist, review-then-place, single-send discipline, unknown-result handling. Use before and after every place or cancel.
license: MIT
metadata:
  version: "1.0.0"
  category: desk
---

# Execution protocol

Only **Robin** (Execution Trader) uses this skill to write. MCP mechanics live in `robinhood-mcp`; this skill is the discipline.

## Inputs

- Proposal with Lucius PASS and exact ticket fields
- User approval by id in chat, or standing approval that matches scope
- Agentic account id from desk/risk-limits (not a casual default)

## Pre-send checklist

1. Ticket integrity: id, PASS and approval refer to the same ticket text.
2. Account is Agentic `agentic_allowed` and matches the record.
3. Fresh quote within slippage tolerance.
4. `review_equity_order` / `preview_crypto_order` / `review_option_order` as applicable; surface alerts.
5. Fresh `ref_id` UUID written to the proposal before place.
6. One logical send per approval.
7. No other unreconciled send pending.

Any failure → do not send; hand back to Alfred.

## Send

- Place exactly once with the recorded `ref_id`.
- Capture raw response and timestamp.
- Do not wrap in a blind retry loop.

## Unknown results

Timeout / transport error after the request left = **unknown**:

1. Do not resend.
2. Query orders by id / time / symbol; check positions.
3. If found, reconcile. If not found after spaced checks, report unconfirmed; new send needs fresh approval.

## Reconciliation

Write broker facts under `## reconciliation`, post the execution report, DM Gordon.

## Cancels and replaces

Own ticket (or standing that covers that class). Cancel by order_id after confirming ownership on Agentic. Confirm removal from open orders.

## Never

- Never send without PASS + approval.
- Never write non-Agentic accounts.
- Never retry blind.
- Never size or edit limits.
