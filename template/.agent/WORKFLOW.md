# Backend development workflow

Follow the repository's instructions and the user's current authorized task. These guidelines do not grant production access or override tool permissions.

## Start

Inspect working changes, actual interfaces, schemas, manifests, tests, and deployment configuration. Read active tasks, relevant architecture/spec sections, and the last 20 lines of LOG.md. Preserve unrelated edits. For an uninitialized project, identify the backend's callers, core operation, data, access rules, and success criteria before selecting infrastructure. Leave unknowns explicit; do not assume a queue or multi-tenant model.

## Build and verify

1. Define the requested behavior and observable acceptance criteria. Reconcile stale task ordering with the current user request.
2. Write a short spec for new contracts, persistence changes, or meaningful authorization, concurrency, and failure risks. A localized fix may use an inline plan regardless of file count.
3. Implement a complete small slice using existing patterns. Consider validation, authorization, isolation, retries, concurrency, timeouts, and recovery where relevant.
4. Run relevant checks and inspect failures. Cover negative cases at affected boundaries. Never weaken tests to hide failures; explain legitimate test corrections against the intended contract.
5. Record actual commands, environment, results, and limitations in TESTING.md. Unrun checks are unverified. Do not copy example results as evidence.
6. Update task status and a concise log entry. Mark done only with demonstrated acceptance criteria. Distinguish implemented, verified, and ready for release.

Proceed with routine edits and task-required dependencies within existing policy. Ask for unapproved scope/contract changes, destructive operations, production changes, paid resources, or consequential external actions. Honor existing explicit authorization. Prepare reviewable changes before requesting a decision.

## Backend invariants

- Enforce authentication and operation/resource authorization separately. Test denial paths.
- Tenant foreign keys prevent invalid relationships, not unauthorized reads. Use the selected isolation mechanism and prove cross-tenant denial, including worker paths.
- Define transaction boundaries and uniqueness constraints for concurrent writes. For retryable operations, define idempotency scope, duplicate/in-flight handling, and retention; do not assume every mutation needs an idempotency table.
- For workers and integrations, define delivery semantics, bounded retries/timeouts, poison-job handling, and safe replay. Use an outbox when a database write and external delivery must remain consistent.
- Preserve applied/released migrations. Plan staged compatibility and recovery; do not promise a downgrade can restore lost data.
- Never record secrets or sensitive user data. Bound public input, resource consumption, and log payloads.
- For release work, verify configuration, deployment compatibility, alerts, backup restoration where applicable, and the core journey in the target environment. Tests alone do not prove release readiness.
