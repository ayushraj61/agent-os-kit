# Production Agent OS

**Build reliable product backends with AI agents.** A small skill and project workflow for APIs, databases, authentication, workers, and integrations—from a prototype to a backend you can operate.

Created from lessons building [DakNode](https://daknode.com). MIT licensed.

## What it does

Helps an agent inspect the real codebase, clarify backend contracts, implement a small complete slice, verify failure paths, and preserve evidence and decisions between sessions. It fits existing projects as well as new ones without imposing a framework, queue, database, or cloud provider.

The focus is backend engineering. Product context defines what the backend must accomplish; frontend design and general product management are outside the main workflow.

These are written agent instructions, not a security sandbox or automatic enforcement. Production readiness requires evidence from your application and environment.

## Install into a project

Clone this repository to a separate directory, then run:

```bash
git clone https://github.com/ayushraj61/agent-os-kit.git
bash agent-os-kit/install.sh /path/to/your-project
```

The installer adds missing files, preserves all existing files, and rejects conflicting paths and symlinks within template destinations. Re-running it does not update existing copies. Review and merge future workflow improvements deliberately.

It supplies `CLAUDE.md` and `AGENTS.md` entry points pointing to `.agent/WORKFLOW.md`. If either file already exists, add that reference yourself. Automatic discovery depends on your agent and configuration; for other tools, explicitly point them to the workflow. No universal agent compatibility is claimed.

Alternatively, use the root `SKILL.md` as a skill through your agent's supported skill installation mechanism. The references and template directory must remain available beside it. Project installation and skill installation are separate routes; neither requires the other.

## First request

> Inspect this existing backend and initialize only the relevant Agent OS project state. Preserve my stack and working changes. Then implement [feature], including its access rules and failure behavior, and show what you verified.

For a new backend, state the core operation, callers, data, and constraints. The agent should resolve blocking unknowns before choosing infrastructure.

## The workflow

1. Scope behavior and observable acceptance criteria.
2. Plan significant contract, data, authorization, and failure changes; use a short inline plan for localized fixes.
3. Build a complete small slice using actual repository interfaces.
4. Verify relevant success and failure paths.
5. Record real results and limitations.
6. Report and update state; mark done only with demonstrated acceptance criteria.

Routine authorized edits proceed without repeated approvals. Unapproved scope/contract changes, destructive data operations, production mutations, paid resources, and consequential external actions need an explicit decision. Existing authorization remains valid within its scope.

## Files

| File | Purpose |
| --- | --- |
| `SKILL.md` | Skill entry point and routing |
| `references/backend.md` | API, access, persistence, concurrency, and worker decisions |
| `references/release.md` | Evidence-based backend release review |
| `template/.agent/WORKFLOW.md` | Shared installed project instructions |
| `.agent/architecture.md` | Product boundary, real stack, and decisions |
| `.agent/TASKS.md`, `TESTING.md`, `LOG.md` | Active work, observed evidence, and concise handoff |
| `.agent/specs/` | Short backend feature specifications |
| `.agent/MILESTONES.md`, `PHASES.md` | Optional planning for larger delivery |

Templates start uninitialized. They contain no executed tests, selected infrastructure, or pre-approved backlog.

## Validation

```bash
bash -n install.sh
python3 -m unittest discover -s tests -v
```

Installer tests cover new projects, repeated installation, existing instructions/state, paths with spaces, and conflicting/symlink destinations. They verify installation behavior; they do not prove that an agent produces reliable backend code. Evaluate real backend changes and release evidence before making that claim.
