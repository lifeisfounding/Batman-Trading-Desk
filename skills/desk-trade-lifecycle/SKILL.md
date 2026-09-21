---
name: desk-trade-lifecycle
description: End-to-end procedure for one trade on the Batman Trading Desk - from idea to reviewed journal entry - with ticket format, owners, and done criteria. Use whenever the user wants to open, adjust or close a position, or whenever any Bot is about to touch a Robinhood write tool.
license: MIT
metadata:
  version: "1.0.0"
  category: desk
---

# Trade lifecycle

Every position change goes through the same seven stages, in order.

```
idea -> evidence -> risk sign-off -> user approval -> execution -> reconciliation -> review
Alfred  Oracle/Vicki   Lucius           user            Robin         Robin            Gordon
```

## 0. Open a proposal

**Owner: Alfred.** Assign `BT-YYYYMMDD-NN` and create `/workspace/trading-desk/proposals/<id>.md`:

```markdown
# BT-20260921-01

- opened: <time> by user
- venue: Robinhood Agentic  account: Agentic account
- idea: <user's idea in one line>
- status: evidence

## evidence
## risk
## approval
## execution
## reconciliation
## review
```

## 1. Evidence

**Owners: Oracle, and Vicki when needed.** Quote, book, tradability, catalysts. Write under `## evidence` with sources and times.

## 2. Risk sign-off

**Owner: Lucius.** Live portfolio, limits, arithmetic, PASS ticket or REJECT. See `desk-risk-limits`.

Example PASS ticket shape:

```
TICKET BT-20260921-01 | Agentic account
symbol: …  side: buy  qty: …  type: …  TIF: …  session: …
stop: … (if required by limits)
risk: $… = …% of equity $… (get_portfolio <time>)
risk sign-off: PASS <time>, risk-limits.md vN
expires: <time>
approve with: "approve BT-20260921-01"
```

## 3. User approval

**Owner: the user.** Literal `approve BT-…` after the ticket was shown, **or** a standing approval that matches scope. "Yes" / thumbs-up is not enough unless standing covers it. Alfred records under `## approval`.

## 4. Execution

**Owner: Robin.** Pre-send checklist (`desk-execution-protocol`), review then place once, record under `## execution`.

## 5. Reconciliation

**Owner: Robin.** Broker order/position state under `## reconciliation`. Unknown results: do not resend.

## 6. Review

**Owner: Gordon.** Journal now; full review when closed. Process and outcome graded separately.

Adjusting, adding, reducing and closing are trades too: same path, new ticket under related id (`-B`, `-C`…) as needed.
