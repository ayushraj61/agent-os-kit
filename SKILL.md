---
name: production-agent-os
description: Enforces the 8-Step Agentic Engineering Workflow, spec-first architecture, change control gates, and strict verification loops to build production-grade backends with AI without falling into vibe coding.
---

# Production Agent OS — Agentic Engineering Skill

This skill transforms an AI agent from an unconstrained "vibe coder" into a disciplined systems engineer operating inside strict architectural and verification guardrails.

## When to Apply This Skill
Apply this skill whenever you are:
- Building a backend system, microservice, API, or database layer with an AI agent.
- Working with terminal agents (Claude Code, Antigravity, Codex, Cursor terminal).
- Preventing context drift, hallucinated database columns, or broken migrations.
- Working on a codebase where production uptime and data integrity matter.

---

## The Core Invariants

### 1. The 8-Step Coder Workflow
Never write code spontaneously. Follow the loop:
1. **Check Tasks** (`.agent/TASKS.md`)
2. **Read/Write Spec** (`.agent/specs/`)
3. **Implement Minimal Code**
4. **Test & Evidence** (Terminal execution recorded in `.agent/TESTING.md`)
5. **Mark Done** (`[x]` in `TASKS.md`)
6. **Log Work** (`.agent/LOG.md`)
7. **Regression Check** (Verify earlier phases still pass)
8. **No Evidence, No Done** (Never conclude without CLI proof)

### 2. Change Control Protocol
STOP and ask human permission before:
- Altering approved specs or architecture boundaries.
- Deleting or rewriting pre-existing working code.
- Changing database schemas where real data exists.
- Adding new external dependencies/packages.

Format problem presentation when stopping:
`What is wrong -> Proposed solution -> Compromises/trade-offs -> Does it make system better or worse.`

### 3. Verification & Guardrail Rules
- **Tests Are Immutable Judges:** If a test fails, the agent must fix the application code. The agent is strictly forbidden from changing test assertions to make broken code pass.
- **Context Hygiene:** Read only the last 15-20 lines of `LOG.md`; never dump megabytes of files into the context window.
