# Batman Trading Desk

**Turn your Grok Bot into a 7-agent Robinhood trading desk.**

Paste this repo into [Grok Bot](https://x.ai/bot). About fifteen minutes later you have research, risk, execution and review as separate agents, sitting in one group chat called **Batcave**, wired into the [Robinhood Trading MCP](https://agent.robinhood.com/mcp/trading). They brief you on markets, size tickets from live account state, send only after Risk PASS (and chat or standing approve), and tell you honestly how it went. **You bring the ideas.** Blake helps you turn them into explicit rules — this pack ships no strategies.

This is documentation and operating instructions for a desk. **Not financial advice.** Markets can move against you. Nothing here promises returns.

Upstream inspiration: [HyperGrok trading desk](https://github.com/galleonlabs/hypergrok-trading-desk) (Hyperliquid). This fork keeps the same team shape and moves it to Robinhood Agentic trading. See [docs/HYPERLIQUID-ORIGIN.md](docs/HYPERLIQUID-ORIGIN.md).

## Start

Repo: https://github.com/lifeisfounding/Batman-Trading-Desk

Open Grok Bot and paste this to any Bot:

> Set up the Batman Trading Desk from https://github.com/lifeisfounding/Batman-Trading-Desk/blob/main/SETUP.md. Follow that file from top to bottom, create the seven Bots and the **Batcave** group chat, install the skills, and finish with the receipt it asks for.

Or clone locally:

```bash
git clone https://github.com/lifeisfounding/Batman-Trading-Desk.git
```

Working files for the live desk stay in `/workspace/trading-desk`.

## Meet the desk

| Bot | What they do for you |
| --- | --- |
| **Alfred** (Desk Lead) | Your main contact. Routes the floor, keeps every trade moving through the same clean process. Never places orders. |
| **Oracle** (Market Analyst) | Live Robinhood market data via Trading MCP: quotes, books, historicals, tradability. Timestamped and sourced. |
| **Vicki** (Research Analyst) | News, fundamentals, earnings, catalysts, counter-evidence. |
| **Blake** (Strategist) | Turns **your** idea into explicit rules, backtests honestly, paper methods. Ships no house strategy. |
| **Lucius** (Risk Manager) | Written limits, live sizing, PASS/REJECT. Can say no. |
| **Robin** (Execution Trader) | The only Bot that may call Robinhood **write** tools after Risk PASS + standing or chat approve. |
| **Gordon** (Trade Reviewer) | Desk journal and post-trade review (off the floor by DM). |

Six sit together in **Batcave**; **Gordon** (Trade Reviewer) works by DM. Every trade follows the same path:

```
idea -> evidence -> risk sign-off -> approval (chat or standing) -> one send -> reconciliation -> review
```

## A day on the desk

**"Brief me on AAPL."** Oracle pulls quote, close, fundamentals snapshot and depth from the Trading MCP, and posts a brief with sources and times (America/Toronto / ET as relevant).

**"I want to buy 10 shares of XYZ at the ask."** Alfred opens `BT-YYYYMMDD-NN`, Lucius reads the Agentic account live and comes back with PASS or REJECT and a ticket. You type `approve BT-...` (unless you have written a scoped standing approval). Robin reviews then places once, reconciles from broker state, and reports.

**"Help me test whether my mean-reversion idea has any edge."** Blake writes rules with you, pulls historicals, runs an honest backtest with costs, and reports the trade distribution — not a headline return. Like it? Paper the lifecycle before live.

## Built for real money (controls)

- **Lucius** sizes from live portfolio state and can REJECT.
- **Robin** is the only writer. MCP **reads** may span accounts; **writes** only the Agentic (`agentic_allowed`) account named in the desk record.
- Approval is either the ticket phrase (`approve BT-YYYYMMDD-NN`) or a **standing approval** written into `desk.md` / `risk-limits.md` with date and scope.
- Grok Bot Auto-review may still show a tap card; treat it as part of send discipline.
- **Gordon** grades process separately from outcome.
- The desk ships **no** strategy playbooks. Your rules live under `/workspace/trading-desk/strategies/` when you create them.

## Also runs in Grok Build, Cursor and Claude Code

The same `agents/`, `skills/` and `rules/` load as a plugin. Open the repository, enable it, run `/desk-operating-model`.

## Inside the repository

```
SETUP.md     what your Grok Bot follows to build the desk
agents/      seven roles: Bot profile card + full system prompt
skills/      desk-* skills + robinhood-mcp
docs/        architecture, FAQ, provenance, Hyperliquid origin
```

| Doc | |
| --- | --- |
| [How the desk works](docs/ARCHITECTURE.md) | roles, files, trust boundaries |
| [FAQ](docs/FAQ.md) | MCP, approvals, customising the team |
| [Skills index](skills/README.md) | every skill and who uses it |
| [Provenance](docs/PROVENANCE.md) | sources and licences |
| [Contributing](CONTRIBUTING.md) · [Security](SECURITY.md) · [Changelog](CHANGELOG.md) | |

MIT. Adapted from [HyperGrok](https://github.com/galleonlabs/hypergrok-trading-desk) for Robinhood Agentic multi-bot desks.
