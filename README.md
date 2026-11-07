# Production Agent OS

**Turn product ideas into reliable backends with AI agents—even while learning backend engineering.** A small skill and project workflow for APIs, databases, authentication, workers, and integrations—from a prototype to a backend you can operate.

Created from lessons building [DakNode](https://daknode.com). MIT licensed.

## What it does

Helps an agent inspect the real codebase, clarify backend contracts, implement a small complete slice, verify failure paths, and preserve evidence and decisions between sessions. It fits existing projects as well as new ones without imposing a framework, queue, database, or cloud provider.

The main audience is students and developers who can describe a product but may not know which backend requirements to ask for. The skill directs the agent to supply that engineering judgment: ask understandable questions, recommend proportionate choices, and investigate relevant failure paths before they become production bugs.

The focus is backend engineering, with attention to frontend integration: API contracts, sessions, errors, and permissions. Standalone visual design remains outside the main workflow.

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

For a new backend you can start with:

> I want students to save private study notes. I don't know backend development. Help me build the first useful operation, explain important choices, and show what remains before real users.

You do not need to arrive with an architecture. The agent should clarify ownership and important behavior, recommend an approach, and build one operation with its persistence, permissions, and relevant failure checks.

## How this helps less experienced developers

| Guidance | Practical benefit |
| --- | --- |
| Product-language questions and explained recommendations | You can decide who may access data without first learning architecture terminology. |
| Feature-triggered failure prompts | The agent investigates relevant duplicates, access leaks, races, and recovery even when you do not mention them. |
| One complete backend operation at a time | You can try and verify useful behavior before adding more layers or services. |
| Client integration checks | Frontend requests, sessions, and errors fit the backend without weakening server protections. |
| Evidence-based progress levels | “Works locally” is separated from “verified” and “ready for the intended release,” with next actions for gaps. |

These instructions aim to reduce avoidable failures; they cannot guarantee a world-class product or replace review and operational experience for consequential systems.

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
| `template/.agent/guides/backend-delivery.md` | Beginner guidance, hidden requirements, useful slices, and readiness levels |
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

Behavioral evaluation cases and a scoring protocol are in [evaluations/README.md](evaluations/README.md). They cover beginner projects, access boundaries, duplicate callbacks, concurrency, client integration, missing verification, and small fixes. They are a way to test the technique, not evidence that it has already outperformed ordinary prompting.
