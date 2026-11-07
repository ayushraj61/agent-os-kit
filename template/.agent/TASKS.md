# Project Tasks Tracker

*This is the active execution registry for AI agents and developers. An agent must only work on the next unblocked task in the current phase.*

---

## Phase 1: Foundation & Project Setup
*Status: In Progress*

- [ ] **Task 1.1: Database Schema & Migration Bootstrap**
  - **Spec:** `.agent/specs/01_database_schema.md`
  - **Scope:** Create initial migration, tables, and tenant isolation foreign keys.
  - **Acceptance Criteria:** `alembic upgrade head` runs cleanly; rollback `downgrade -1` runs cleanly.
  - **Evidence:** Record output in `.agent/TESTING.md`.

- [ ] **Task 1.2: Core Domain Model & Unit Tests**
  - **Spec:** `.agent/specs/02_core_domain.md`
  - **Scope:** Implement domain entities, serialization schemas, and unit test suite.
  - **Acceptance Criteria:** Unit tests pass with 100% assertions green.
  - **Evidence:** Record test runner output in `.agent/TESTING.md`.

---

## Phase 2: API Endpoints & Verification
*Status: Pending*

- [ ] **Task 2.1: Health & Readiness Endpoints**
  - **Scope:** Implement `GET /health` (liveness) and `GET /health/ready` (checks DB and cache).
  - **Acceptance Criteria:** Returns 200 OK with dependency status JSON.

---

## Phase 3: Background Workers & Pipelines
*Status: Pending*

- [ ] **Task 3.1: Worker Queue Bootstrap**
  - **Scope:** Configure background queue worker and idempotency wrapper.
  - **Acceptance Criteria:** Tasks process with retries and exponential backoff.

