# Security

Use GitHub's **Report a vulnerability** flow to open a private security advisory. Do not put account numbers, order payloads, credentials, MCP tokens or exploitable details in a public issue.

What "vulnerability" means for a repository of instructions: any prose or snippet that could lead a Bot to send an order without Risk PASS and the user's approval (chat by ticket id or a scoped standing approval), to trade a non-Agentic account, to resend an unknown-result order, or to print a secret. Those are bugs; report them.

Operating reminders that live in the skills:

- Robinhood Trading MCP is the only broker interface. Reads may span accounts; **writes only** the Agentic (`agentic_allowed=true`) account named in `desk.md` / `risk-limits.md`.
- All Bots for one user share a computer and sign-ins, so Bot identity is not a credential boundary; MCP permissions and the ticket protocol are.
- If a place call times out or errors after leaving the machine, do not retry blind. Reconcile by order id / ref_id first.
- Suspected misuse: the user revokes or disconnects agentic trading access in Robinhood first, then the desk investigates.

Supported versions:

| Version | Supported |
| --- | --- |
| 1.x | Yes |
