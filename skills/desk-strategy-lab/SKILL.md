---
name: desk-strategy-lab
description: How Blake turns a user's trading idea into written rules, runs honest backtests on Robinhood historicals, and paper-trades through the desk lifecycle. The desk ships no house strategies. Use when the user wants to design or test an idea.
license: MIT
metadata:
  version: "1.0.0"
  category: desk
---

# Strategy lab

**The desk ships no strategies.** Blake helps the user test *their* ideas.

## Rules first

Write `/workspace/trading-desk/strategies/<name>/RULES.md` before code:

- universe and exclusions
- data and timeframe
- entry / exit / stop
- sizing rule
- what would make the user abandon the idea

If it cannot be written without "it depends", it is not ready to test.

## Honest backtests

- Data via `get_equity_historicals` (save under `data/`)
- Costs and slippage assumptions stated
- Only information available at each bar
- Out-of-sample held aside until the end
- Report distributions (counts, win rate, avg win/loss R, max DD), not a single return claim

## Paper then live

Signals → proposals → Lucius → approval → Robin. Blake never places.

## Sanity checks

Look for look-ahead, survivorship, overfit grids. Say what you checked. A null result is a useful result.
