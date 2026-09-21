# Set up the Batman Trading Desk

You are a Grok Bot building the user's **Robinhood Agentic** trading desk from this repository. Follow this file top to bottom. When you finish, the user has seven specialist Bots (six on a **Batcave** group chat, one reviewer by DM), shared skills, prepared working folders under `/workspace/trading-desk`, and a written desk record. About fifteen minutes. Setup is read-only: no orders.

## 1. Get the repository onto the desk computer

```bash
mkdir -p /workspace && cd /workspace
git clone --depth 1 https://github.com/lifeisfounding/Batman-Trading-Desk.git batman-trading-desk \
  || (curl -L https://github.com/lifeisfounding/Batman-Trading-Desk/archive/refs/heads/main.tar.gz | tar xz && mv Batman-Trading-Desk-main batman-trading-desk)
ls /workspace/batman-trading-desk/agents /workspace/batman-trading-desk/skills
```

If you cannot reach GitHub, ask the user to attach the archive and unpack it to `/workspace/batman-trading-desk`.

## 2. Read the desk

Read these before creating anything:

1. `docs/ARCHITECTURE.md` — how the team fits together.
2. `skills/desk-operating-model/SKILL.md` — the rules every Bot follows.
3. All seven files in `agents/` — each has a **Bot profile** (Name, Job, Description) and a full **System prompt**.
4. `skills/README.md` — the index of skills and which Bot uses which.

## 3. Prepare the desk computer (read-only)

Confirm the Robinhood Trading MCP is connected in the user's workspace (`https://agent.robinhood.com/mcp/trading`). Create working folders (do not invent live equity or tickets):

```bash
mkdir -p /workspace/trading-desk/{proposals,briefs,research,strategies,data,journal/incidents,watch}
```

Optional template files (placeholders only):

- `/workspace/trading-desk/desk.md` — engagement level, Bot list, Batcave, standing approvals (no real account numbers in anything you publish).
- `/workspace/trading-desk/risk-limits.md` — Lucius runs the interview in `desk-risk-limits` with the user.

## 4. Create the Bots

For each file in `agents/`, create one Bot. Use the profile card **exactly**:

| File | Name | Job |
| --- | --- | --- |
| `agents/alfred.md` | Alfred (Desk Lead) | Head of the Batman Trading Desk |
| `agents/oracle.md` | Oracle (Market Analyst) | Robinhood market data and microstructure |
| `agents/vicki.md` | Vicki (Research Analyst) | Fundamentals, news and catalyst research |
| `agents/blake.md` | Blake (Strategist) | Strategy design and testing partner |
| `agents/lucius.md` | Lucius (Risk Manager) | Risk limits, position sizing and book oversight |
| `agents/robin.md` | Robin (Execution Trader) | Order execution on Robinhood Agentic |
| `agents/gordon.md` | Gordon (Trade Reviewer) | Desk journal and post-trade review |

For each Bot:

- **Name** and **Job** from the profile card.
- **Description** from the profile card, verbatim.
- **Avatar:** optional image from `/workspace/batman-trading-desk/assets/` (or the user picks their own).
- Then send the new Bot its full **System prompt** section as its first message, prefixed with: "These are your standing instructions. Confirm you have read them and state your job in one sentence." Ask it to keep the instructions in memory and to re-read its file at `/workspace/batman-trading-desk/agents/<file>.md` whenever it is unsure.

Seven Bots, not one: the separation between the Bots that read and the one Bot that writes is the design.

## 5. Install the skills

Skills in Grok Bot are shared across all of the user's Bots. For each directory under `skills/`, read `SKILL.md` and save it as a skill using the `name` in its frontmatter. Keep the content unchanged. If the app cannot save a skill of that length, save a short pointer skill instead: "When this skill is used, read `/workspace/batman-trading-desk/skills/<name>/SKILL.md` and follow it."

Skills to install:

- Desk: `desk-operating-model`, `desk-trade-lifecycle`, `desk-risk-limits`, `desk-execution-protocol`, `desk-monitoring`, `desk-post-trade-review`, `desk-incident-response`, `desk-strategy-lab`
- Venue: `robinhood-mcp`

Tell each Bot which skills are its own (listed in its agent file's frontmatter). Any Bot may read any skill; **Robin** (Execution Trader) is the only Bot that acts on Robinhood **write** tools (`place_*`, `cancel_*`, and place after `review_*` / `preview_*`).

## 6. Create the Batcave

Create one group chat named **Batcave** with exactly these six Bots: Alfred (Desk Lead), Oracle (Market Analyst), Vicki (Research Analyst), Blake (Strategist), Lucius (Risk Manager), Robin (Execution Trader). (Grok Bot group chats hold up to six Bots; Gordon works from its own conversation and by DM.)

Post this as the first message in the group:

> Welcome to the Batcave. Alfred routes; Oracle and Vicki bring evidence; Blake helps the user test their own ideas; Lucius sizes and can refuse; Robin is the only Bot that sends orders, on a ticket Lucius passed and the user approved (chat phrase or standing approval written in desk/risk-limits). Rules: `/workspace/batman-trading-desk/skills/desk-operating-model/SKILL.md`. Gordon is a DM away. Today is setup: nothing goes to the broker. This desk ships no strategies — the user brings the ideas.

## 7. Approvals

Ask the user to open **Settings, General, Auto-review** and keep Require Approval for financial / broker write actions unless they have deliberately chosen a standing approval for a named scope. The desk's own protocol still holds: Robin sends only after Lucius PASS and either `approve BT-<id>` in chat or a scoped standing line in `desk.md` / `risk-limits.md`. Broker writes always stay behind that gate.

## 8. Write the desk record

Ask the user two questions, then write `/workspace/trading-desk/desk.md` with **placeholders only** (never paste real account numbers into a public repo; keep live ids only on the desk computer if the user wants them there):

1. Engagement level: **research** (MCP reads only), **paper** (method rehearsal, no live sends), or **live Agentic**.
2. Confirm the tradable account nickname (e.g. Agentic) — record as `Agentic account` unless the user wants the live id stored privately on the box.

```markdown
# Desk record

- created: <UTC timestamp>
- venue: Robinhood Agentic Trading (MCP)
- engagement level: research | paper | live
- tradable account: Agentic account (agentic_allowed only)
- bots: Alfred (Desk Lead), Oracle (Market Analyst), Vicki (Research Analyst), Blake (Strategist), Lucius (Risk Manager), Robin (Execution Trader), Gordon (Trade Reviewer)
- group chats: Batcave (6)
- risk limits: not yet written  (Lucius runs the interview: skills/desk-risk-limits)
- standing approvals: none
- status: research-only until the user enables live sends
```

Then hand Lucius the `desk-risk-limits` interview.

## 9. Verify the desk (read-only)

Run these and record the results:

1. In Batcave: "@Oracle (Market Analyst) brief us on a major name (e.g. AAPL)." Expect a timestamped brief with MCP sources.
2. "@Lucius (Risk Manager) assuming a placeholder equity of 10,000 USD and draft limits, size a hypothetical whole-share buy with a 1% stop." Expect PASS or REJECT with arithmetic and a ticket, noting nothing will be sent.
3. "@Robin (Execution Trader) what would you need before sending that ticket?" Expect the pre-send checklist and a refusal to send without PASS + approval.
4. DM Gordon: "Open today's journal and record that the desk was set up." Expect a journal entry.
5. Ask Vicki for one sourced fact about a scheduled catalyst (earnings calendar via MCP is fine).

## 10. Return the receipt

Finish by giving the user:

- the seven Bots and how each was created
- the skills installed and how (saved in full, or as pointers to files)
- the Batcave group and its members
- the desk record and its engagement level
- the results of the five verification checks
- confirmation that setup stayed read-only: no order placed

Then say: "The Batcave is ready. Ask Alfred for a market brief to see it work. When you want to trade live, say 'set my risk limits' and Lucius will walk the interview; Robin still needs Risk PASS and your approval (or a scoped standing approval you wrote) on every ticket."

## If you are not Grok Bot

Grok Build, Cursor and Claude Code load `agents/`, `skills/` and `rules/` from this repository as a plugin. Open the repository, enable the plugin, and run `/desk-operating-model` to begin. The same seven roles apply; group chats become subagents or role-labelled passes, and the approval model is unchanged.
