# Production Agent OS — Master Agent Coder Instructions

**This file is auto-loaded at session start. It is the authoritative operating manual for this repository.**
All Agent OS governance and state documents live in `.agent/`. Paths below are relative to the repository root.

---

## 1. The 8-Step Coder Workflow
For every feature or task you build, you MUST follow this exact loop:

1. **Check `.agent/TASKS.md`** — Confirm this is the next unblocked task in the current phase.
2. **Read/Write Spec** — For any feature touching >1 file, a new API endpoint, or database schema change: read or write `.agent/specs/[feature-name].md` first. Trivial 1-line bugfixes or typo corrections can skip this step.
3. **Implement** — Write the minimal production code satisfying the spec.
4. **Test & Evidence** — Write automated tests, execute them in the terminal, and record concise CLI evidence in `.agent/TESTING.md`.
    - *If tests fail:* Do not mark DONE. Do not move to the next task. Fix the code, re-test, and only proceed when green. Log the failure and fix in `.agent/LOG.md`.
5. **Mark Done** — Update `.agent/TASKS.md` status to `[x] DONE`.
6. **Log Work** — Append a concise entry to `.agent/LOG.md` with timestamp, summary, and files changed.
7. **Regression Check** — Before moving from one phase to the next, execute the regression test suite recorded in `.agent/TESTING.md`. No new phase can start if existing functionality is broken.
8. **No Evidence, No Done** — NEVER mark a task DONE without terminal test evidence recorded in `.agent/TESTING.md`.

---

## 2. Change Control — When to Stop and Ask

> [!CAUTION]
> **STOP and ask the user for approval before doing any of the following. Do not proceed on assumption.**

- Changing an approved spec, `.agent/architecture.md`, or the scope of any feature.
- Deleting or rewriting working code that predates the current session.
- Dropping, deferring, or silently narrowing an agreed requirement.
- Modifying a database schema or migration after real data exists in any environment.
- Installing new third-party dependencies or external packages.

### How to Stop and Present a Problem:
When stopping to request human approval, present your reasoning in this exact order:
1. **What is wrong / blocking**
2. **The proposed technical solution**
3. **What trade-offs or compromises it introduces**
4. **Whether it makes the system objectively better or worse**
*Then wait for human authorization.*

### What Does NOT Require Stopping:
- Creating or updating a spec as explicitly required by an approved `.agent/TASKS.md` task.
- Fixing bugs in code written during the current session against an approved spec.
- Recording an implementation decision into `.agent/architecture.md` or a feature spec, provided it does not change approved scope, behavior, or acceptance criteria.

---

## 3. Hard Engineering Rules

1. **Never Vibe Code:** Do not guess database columns, API parameters, or library APIs. Inspect the actual schemas, type definitions, and lockfiles first.
2. **Never Weaken Tests to Pass Broken Code:** If an automated test fails, fix the application code. Never modify assertions or delete tests merely to obtain a green checkmark unless the spec itself was explicitly changed with human approval.
3. **No Phantom Packages:** Do not install new third-party libraries without asking. Always prefer the language standard library or packages already present in the dependency lockfile.
4. **Schema Migrations Are Immutable:** Never edit a migration that has already been executed or committed to main. Always generate a forward migration. Ensure all migration downgrades are clean and tested.
5. **Data Isolation & Multi-Tenancy:** If this is a multi-tenant system, every tenant-owned table must include the tenant identifier (`org_id` / `tenant_id`) and composite foreign keys. Bare column filtering is not isolation.
6. **Zero Secrets in Code or Logs:** Never log, print, or commit API keys, tokens, or environment credentials—not in application code, not in git history, and not in `.agent/LOG.md` or `.agent/TESTING.md`.

---

## 4. Documentation Discipline (Token-Efficient Context)

Every document in `.agent/` is loaded or inspected across sessions. Verbose explanations waste context tokens on every invocation. **Compress narration; never sacrifice technical facts.**

- **Architectural decisions live in `.agent/architecture.md` or feature specs**, including the *why* and the *consequences*.
- **`.agent/LOG.md`** records what changed, bugs discovered, and replaced decisions in 2-3 lines per entry.
- **`.agent/TESTING.md`** records concise test commands, pass/fail counts, and execution exit codes. Never paste raw megabytes of terminal output.
- **Git commits** should be clean and descriptive, but git history must never be the *only* place an architectural invariant is documented.

---

## 5. Context Efficiency & Session Start Order

When beginning a new session or after a context reset, follow this strict loading sequence to prevent context window bloat:

1. Read `.agent/TASKS.md` to identify the current phase and active task.
2. Read **only** the sections of `.agent/architecture.md` relevant to the current task.
3. Read the relevant feature spec inside `.agent/specs/`.
4. Read **only the last 15-20 entries** of `.agent/LOG.md`. Never ingest the entire history.
5. Begin the 8-Step Coder Workflow.

---

## 6. Proportional Verification

Verification must be relevant, sufficient, and non-duplicative:
- For backend code changes: Run the affected backend unit and integration test suite.
- For documentation or `.agent/` updates: Run linting/syntax checks only. Do not trigger expensive integration suites for markdown edits.
- Before committing or completing a phase: Run the full authoritative regression suite.

