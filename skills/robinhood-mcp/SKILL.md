---
name: robinhood-mcp
description: How the Batman Trading Desk uses Robinhood Trading MCP (https://agent.robinhood.com/mcp/trading) - account boundaries, read vs write tools, review-then-place, ref_id idempotency, and reconciliation. Use for any market data, portfolio, or order action on Robinhood.
license: MIT
metadata:
  version: "1.0.0"
  category: venue
  mcp: "https://agent.robinhood.com/mcp/trading"
---

# Robinhood Trading MCP

Connector: `https://agent.robinhood.com/mcp/trading` (in this workspace often `user-robinhood-trading` / `user-Robinhood-xai`).

## Account boundary

- `get_accounts` lists brokerage accounts. Exactly one should be `agentic_allowed=true` for agent trading — the **Agentic** account in the desk record.
- **Reads** may span accounts when the user asks (portfolio compare, etc.).
- **Writes** (`place_*`, `cancel_*`, exercise, and other state-changing tools) **only** on the Agentic account. Never invent a default account_number; take it from the user or the desk record after confirming `agentic_allowed`.

Buying power: use `get_portfolio`, not guesses from `get_accounts`.

## Read tools (typical)

Market: `get_equity_quotes`, `get_equity_price_book`, `get_equity_historicals`, `get_equity_fundamentals`, `get_equity_technical_indicators`, `get_equity_tradability`, `get_equity_news`, `search`, indexes, crypto quotes, scanners (`get_scans`, `run_scan`, …).

Account: `get_portfolio`, `get_equity_positions`, `get_equity_orders`, `get_option_*`, `get_crypto_*`, `get_realized_pnl`, `get_pnl_trade_history`, tax lots.

Research: earnings, financials, analyst ratings, SEC filing tools, politician trades (public disclosures).

Always cite tool name + time on numbers you report.

## Write tools (Robin only)

Equities: `review_equity_order` → `place_equity_order`; `cancel_equity_order`; advanced OCO review/place/cancel.

Crypto: `preview_crypto_order` → `place_crypto_order`; cancel.

Options: `review_option_order` → `place_option_order`; cancel; exercise only with explicit user confirmation per tool rules.

Watchlists/alerts/scans: also writes — require user confirmation; prefer Alfred routing and Lucius awareness if they change desk behaviour.

### Review then place

Default: call review/preview first, present alerts, then place with the **same** parameters and a client `ref_id` UUID. Re-send the **same** `ref_id` only on transient retries of the same logical order after reconciliation says it did not land. New order → new `ref_id`.

### Sessions and types

Respect tool rules: e.g. market orders are regular-hours oriented; extended/overnight often need limits; fractionals and dollar orders have constraints. Prefer whole shares unless limits explicitly allow otherwise.

### After 16:00 ET

A regular-hours market order placed after the close may queue for the next open. If the user's ticket forbids next-open fills, do not place; return to Alfred.

## Reconciliation

After any write: fetch the order by id, list recent orders, confirm positions and portfolio. Report broker state. Unknown transport result → do not blind retry (see `desk-execution-protocol`).

## Who may write

Only **Robin** (Execution Trader), after Lucius PASS + user approval (chat by ticket id or matching standing). Everyone else: reads only.
