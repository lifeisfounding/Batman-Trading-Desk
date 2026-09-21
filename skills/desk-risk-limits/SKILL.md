---
name: desk-risk-limits
description: How Lucius writes risk limits with the user, sizes trades from live Robinhood Agentic portfolio state, checks the book, and issues PASS or REJECT with exact ticket fields. Use for setting or changing limits, sizing any trade, and answering how is the book.
license: MIT
metadata:
  version: "1.0.0"
  category: desk
---

# Risk limits and sizing

The desk imposes no secret house limits. The user sets them in writing; Lucius enforces them with live data. Broker constraints (tradability, buying power, PDT/GFV rules on the account type) always apply on top.

## 1. Write the limits file

Interview the user, then write `/workspace/trading-desk/risk-limits.md`. Version and date every change. Only the user changes it.

```markdown
# Risk limits v1 - <date> - set by user

- venue: Robinhood Agentic Trading (MCP)
- tradable account: Agentic account (agentic_allowed only; never write other accounts)
- equity basis: live get_portfolio on Agentic; never from memory
- max risk per trade: e.g. 0.5% of equity   # loss if stop hit, if stops used
- max total open risk: e.g. 2% of equity
- max positions: e.g. 3
- allowed instruments: listed equities on Agentic (add crypto/options only if user opts in)
- options: forbidden unless user explicitly enables
- stops: mandatory | optional (user choice)
- daily loss stop: e.g. -2% of start-of-day equity -> no new risk until user resets
- max slippage tolerance at send: e.g. 10 bps
- standing approvals: none
- notes:
```

Do not invent unspecified fields. Record what the user chooses.

## 2. Size a trade

### 2.1 Live state

- `get_accounts` → confirm Agentic `agentic_allowed`
- `get_portfolio` for equity / buying power
- `get_equity_positions` / open orders as needed
- `get_equity_tradability` for the symbol
- Oracle's fresh quote / book

Missing or stale → REJECT.

### 2.2 Arithmetic (show every line)

When stops are mandatory:

```
risk_usd      = equity x max_risk_pct
stop_distance = |entry - stop|
raw_qty       = risk_usd / stop_distance
qty           = floor(raw_qty)            # whole shares unless limits allow fractionals
check         qty >= 1
check         notional <= buying power with buffer
check         open risk / position count / allowed list / daily loss stop
```

When the user sizes by fixed shares or dollars, still check every gate against limits and buying power.

### 2.3 Output

PASS: inputs, sizing, book after, gates, exact ticket fields, next owner.
REJECT: `gate failed: <one gate, the numbers>`.

## 3. Book check

On request: positions, orders, buying power, daily PnL vs stop — timestamped from live MCP calls.

## Never

- Never loosen a limit mid-ticket.
- Never size from memory.
- Never approve writes to non-Agentic accounts.
