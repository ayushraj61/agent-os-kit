# Production Agent OS 🛡️
> **The Anti-Vibe-Coding Framework for AI Agents.**  
> Drop-in governance, spec-driven architecture, and terminal guardrails to build reliable backends with Claude Code, Cursor, and AI agents—without breaking your codebase.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Engine: Claude Code / Codex / Antigravity](https://img.shields.io/badge/Agent-Claude%20Code%20%7C%20Codex%20%7C%20Cursor-orange.svg)](#)

---

## The Problem: Why "Vibe Coding" Breaks Backends

Right now, everyone is talking about "vibe coding"—throwing conversational prompts at an LLM and hoping a production-ready system appears.

That works for weekend toy demos or static landing pages. But on backend infrastructure, vibe coding is a disaster:
- **Context Rot:** Across extended sessions, unanchored agents suffer context drift—forgetting architectural constraints and hallucinating database columns or API parameters that don't exist.
- **Silent Weakening:** When tests fail, agents often modify assertions or delete checks just to get a green tick instead of fixing the broken application logic.
- **Hidden Invariants:** Beginners often don't know to ask for idempotency keys, race condition guards, or atomic counters—and the AI won't volunteer them unless forced.
- **Zero Accountability:** When an asynchronous worker silently drops jobs at 2 AM due to an environment mismatch, the AI isn't on call—**you are**.

**Production Agent OS** is a lightweight, drop-in engineering framework that turns AI agents from unconstrained vibe coders into disciplined backend engineers operating inside strict architectural boundaries.

---

## Origin Story

Built out of necessity while building [DakNode](https://daknode.com) (API-first communication infrastructure for AI agents) as a solo backend developer. 

After spending nearly two days tracking down a silent worker container configuration bug that no AI prompt could magically solve, this system was codified: **AI gives you execution speed, but human-enforced architectural guardrails give you production uptime.**

---

## The 6-Step Implementation Loop

Every backend feature built by the agent follows this closed execution loop:

```mermaid
flowchart TD
    A["1. Scope<br/>(Define behavior & observable criteria)"] --> B["2. Plan<br/>(Write spec for contracts/data/auth; inline for small fixes)"]
    B --> C["3. Build<br/>(Implement complete slice using real interfaces)"]
    C --> D["4. Verify<br/>(Run relevant checks & failure paths)"]
    D --> E{"Tests Green?"}
    E -- No --> F["Fix Code & Re-verify<br/>(Never weaken tests!)"]
    F --> D
    E -- Yes --> G["5. Record<br/>(Capture CLI commands & results in TESTING.md)"]
    G --> H["6. Report & Update<br/>(Mark DONE in TASKS.md & log work in LOG.md)"]
```

---

## What Makes This Different

| Principle | Vibe Coding | Production Agent OS |
| :--- | :--- | :--- |
| **Architecture** | Improvised on the fly from chat prompts | Spec-first (`.agent/specs/`) for significant changes; inline plan for small fixes |
| **Requirements** | Only what the user remembers to ask | Proactively investigates hidden failure modes (races, idempotency, auth) |
| **Testing** | "It ran once on localhost" | Never weaken tests; fixes must satisfy the contract |
| **Context Window** | Flooded with entire files until it hallucinates | Scoped reading: active tasks + relevant specs + last 20 lines of log |
| **Agent Support** | Locked to a single proprietary chat UI | Ready for Claude Code (`CLAUDE.md`), Cursor/Codex (`AGENTS.md`), and skills (`SKILL.md`) |

---

## Proactive Engineering: Discovering Hidden Requirements

The biggest failure mode for developers using AI is **not knowing what backend edge cases to ask for**. 

Production Agent OS equips the agent with a proactive requirement discovery matrix in `guides/backend-delivery.md`:

| Feature Signal | What the Agent Must Investigate | Observable Check |
| :--- | :--- | :--- |
| **Accounts & Workspaces** | Cross-tenant data isolation; session revocation | Attempt cross-workspace reads/writes; verify strict 403/404 denial. |
| **Payments & Webhooks** | Duplicate delivery, provider retries, webhook signature verification | Replay callback payload in sandbox; verify idempotent no-op. |
| **Seats, Credits, Quotas** | Race conditions between concurrent requests | Concurrent requests preserve atomic database limits. |
| **Background Workers** | Crash after side effect, poison job handling, at-least-once delivery | Simulate worker crash mid-task; confirm outbox/retry recovery. |
| **Schema Migrations** | Staged deployment compatibility, zero downtime | Plan forward compatibility; never assume a downgrade restores modified data. |

---

## Quickstart (Install in 10 Seconds)

### Option 1: Drop into an existing repository
Clone the repository and run the installer pointing to your project:

```bash
git clone https://github.com/ayushraj61/agent-os-kit.git
bash agent-os-kit/install.sh /path/to/your-project
```

The installer safely installs `CLAUDE.md`, `AGENTS.md`, and the `.agent/` governance structure into your repository. Existing instruction files and project state are preserved.

### Option 2: Use as an Agent Skill
Point your AI agent directly to `SKILL.md` via your agent's skill loader.

---

## Your First Prompt to the Agent

Once installed, open Claude Code, Cursor, or your terminal agent and paste:

> *"Inspect this repository and initialize only the relevant Agent OS project state. Preserve my existing stack and working changes. Then implement [your feature], including its access rules and failure behavior, and record terminal test evidence before marking done."*

---

## Repository Structure

```text
your-project/
├── CLAUDE.md                 # Entry point for Claude Code (points to WORKFLOW.md)
├── AGENTS.md                 # Entry point for Cursor / Codex / Antigravity
└── .agent/
    ├── WORKFLOW.md           # Master backend development & verification rules
    ├── architecture.md       # Product boundaries, tech stack & database invariants
    ├── TASKS.md              # Phased task list with strict acceptance criteria
    ├── TESTING.md            # Test matrix & terminal evidence ('No Evidence, No Done')
    ├── LOG.md                # 2-3 line rolling changelog to prevent context rot
    ├── guides/
    │   └── backend-delivery.md # Proactive failure discovery & beginner delivery guide
    └── specs/
        ├── README.md         # Spec conventions ('No Spec, No Implementation' for new contracts)
        └── 00_template_spec.md # Feature spec template (Goals, Invariants, Edge Cases)
```

---

## Verification & Evaluations

### 1. Automated Installer Test Suite
The installer is covered by automated Python unit tests ensuring safe execution against directory collisions, existing instruction preservation, and symlink security:
```bash
python3 -m unittest discover -s tests -v
```

### 2. Standardized Behavioral Evaluation Scenarios
In [`evaluations/README.md`](evaluations/README.md), we define 7 repeatable evaluation scenarios to test whether an AI agent demonstrates real engineering judgment:
- Multi-tenant workspace data isolation under direct ID tampering
- Duplicate payment callback idempotency & state protection
- Concurrency race conditions on limited inventory / seat reservations
- Cookie-based authentication & client CORS boundaries
- Resilient recovery and reporting under database outages
- Scoped list and search pagination memory limits
- Localized maintenance fixes without unnecessary ceremony

---

## License

MIT License © 2026 [Ayush Raj](https://github.com/ayushraj61). Free to use, adapt, and build upon.
