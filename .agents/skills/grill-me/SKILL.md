---
name: grill-me
description: Stress-test a plan or design through a focused, one-question-at-a-time decision interview. Use only when invoked as $grill-me.
---

# Grill Me

Interview the user until the important decisions, dependencies, and tradeoffs are explicit and mutually consistent.

Keep the workflow read-only unless the user separately requests implementation.

1. Read the supplied plan and inspect the codebase for facts that can be discovered without asking the user.
2. Identify the highest-leverage unresolved decision.
3. For every question, provide a concise recommended answer and explain the main tradeoff. Do not make the user invent options that the available evidence can narrow down.
4. Resolve prerequisite decisions before downstream ones. Revisit an earlier answer when a later constraint invalidates it.
5. Track settled decisions, open questions, assumptions, and consequences as the interview progresses.
6. End each interview turn with exactly one focused question, then wait for the user's answer before advancing to another branch.
7. Continue until no material branch remains unresolved or the user asks to stop.
8. Finish with a compact shared-understanding summary: the chosen direction, rejected alternatives, outstanding risks, and next actions.
