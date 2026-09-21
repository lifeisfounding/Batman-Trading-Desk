# Hyperliquid origin

This repository started as an adaptation of [HyperGrok](https://github.com/galleonlabs/hypergrok-trading-desk): a seven-role Grok Bot trading desk aimed at Hyperliquid perpetuals.

**What we kept**

- Seven specialist seats, one writer, off-floor reviewer
- Ticket lifecycle: idea → evidence → risk → approval → send → reconcile → review
- Shared `skills/` + `agents/` layout and SETUP receipt pattern
- Working directory `/workspace/trading-desk`

**What we changed**

- Venue: Robinhood Trading MCP instead of Hyperliquid API wallets / `/exchange`
- Cast display names: Alfred, Oracle, Vicki, Blake, Lucius, Robin, Gordon; group chat **Batcave**
- Ticket prefix `BT-` instead of `HG-`
- Dropped Hyperliquid-specific skills (`hyperliquid-*`)
- Desk template only: no house strategy playbooks

Credit and thanks to Galleon Labs for the upstream design.
