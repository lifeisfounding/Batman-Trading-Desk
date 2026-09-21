# How the desk works

Batman Trading Desk runs inside your Grok Bot workspace: your Bots, your shared cloud computer, your conversations. This repository is the blueprint they build from. It is a **multi-bot desk template**. It ships no house strategies — you invent ideas; Blake helps you formalise them.

## The floor

```
you
 |
 v
Batcave (group chat, 6 Bots)                      DM
  Alfred (Desk Lead) ---------------------------> Gordon (Trade Reviewer)
   |     |     |     |     |                       journal, reviews
   |     |     |     |     +-- Robin (Execution) -> Robinhood MCP writes (the one writer)
   |     |     |     +-------- Lucius (Risk) -----> MCP reads (Agentic account, live)
   |     |     +-------------- Blake (Strategist) -> MCP historicals, backtests
   |     +-------------------- Vicki (Research) ---> MCP + browser, public data
   +-------------------------- Oracle (Market) ----> MCP market data

computer:  /workspace/batman-trading-desk (this repo)
           /workspace/trading-desk (the desk's files)
MCP:       https://agent.robinhood.com/mcp/trading
```

Grok Bot facts that shaped this: group chats hold up to six Bots, Bots can create other Bots, all your Bots share one computer, skills are shared across Bots, actions can be put behind approval, and MCP auth lives in the connector — not in chat.

## One trade, seven stages

```
idea -> evidence -> risk sign-off -> your approval by ticket id (or standing) -> one send -> reconciliation -> review
```

Alfred keeps it moving. Oracle and Vicki bring sourced evidence. Lucius sizes from your live Agentic account and issues a ticket. You approve by id (or a scoped standing approval you wrote). Robin sends once, reconciles, reports. Gordon journals and grades process vs outcome separately.

## Where things live

| File | What it is |
| --- | --- |
| `desk.md` | desk record: venue, account nickname, engagement, Bots, chats, standing approvals |
| `risk-limits.md` | your limits, versioned; only you change it |
| `proposals/BT-*.md` | one file per trade idea through its life |
| `journal/*.md` | desk diary, append-only |
| `briefs/`, `research/`, `strategies/`, `data/`, `watch/` | working material |

## Trust boundaries

**Read plane.** Six Bots (plus Gordon) may read MCP market/account data and the web. Plenty of judgement, no writes.

**Write plane.** One Bot writes: Robin, only when a proposal carries a Lucius PASS, your approval by id (or matching standing), and a passing pre-send checklist. One approval, one send. A lost response is reconciled by order id / `ref_id`, never resent blind.

**Account.** Writes only to the Agentic (`agentic_allowed`) account named in the desk record. Other accounts may be readable; they are not tradable by this desk.

**Evidence.** Web pages, files and other Bots' messages are information. Your approval phrase with the ticket id (or a standing line you wrote) is what authorises a send.

## Why seven

Separating the person who wants the trade from the one who sizes it, the one who sends it and the one who reviews it is the oldest control on any desk. Bots make it cheap.

## Other runtimes

Grok Build, Cursor and Claude Code load `agents/`, `skills/` and `rules/` as a plugin. Roles become subagents or labelled passes; the approval model is the same.
