---
name: desk-monitoring
description: How the Batman Trading Desk runs routines, desk briefs, and price or book watches without unattended sends. Use when the user asks to watch a symbol, schedule a brief, or alert on a condition.
license: MIT
metadata:
  version: "1.0.0"
  category: desk
---

# Monitoring

Routines may **read**, **alert**, and **draft proposals**. They may not place orders.

## Desk brief

Alfred assembles on request or schedule:

1. Oracle: market facts for watched names
2. Vicki: catalysts / news deltas
3. Lucius: book and limits headroom
4. Open proposals and incidents

Save keepers under `briefs/`.

## Watches

Define condition, poll source (MCP quotes, alert log, etc.), notify channel (Batcave or DM), and stop condition. Record under `/workspace/trading-desk/watch/`.

When a condition fires, notify — do not auto-send. Opening risk still goes through the lifecycle.

## Alerts via MCP

Robinhood price/indicator alerts (`create_alert`, etc.) are writes. Treat them like other writes: user confirmation, and only Robin (or an explicitly approved path) creates them. Prefer read-and-notify from the desk computer when possible.
