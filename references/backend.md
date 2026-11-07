# Backend engineering decisions

Read the sections relevant to the affected boundary. Choose mechanisms from product requirements and the existing system, not from this list by default.

## API contracts and access

Define callers, request/response schemas, errors, pagination and compatibility. Validate at boundaries. Authenticate callers and authorize each resource/operation, including administrative and background paths. Test unauthenticated, forbidden, malformed, missing, and cross-tenant access. Bound payload sizes and expensive operations; choose rate limits from abuse and capacity risks.

## Persistence and concurrency

Identify ownership, constraints, transaction boundaries, and races. Prove concurrent invariants with integration tests where meaningful. Composite tenant foreign keys protect relationships; pair them with authorization and query scoping or database policies for access isolation. Test reads and writes across tenants, including joins and workers.

Keep applied/released migrations immutable. Use expand/migrate/contract when old and new versions coexist. Assess locks, backfills, runtime, and data recovery. A tested forward fix or restore may be safer than a downgrade; never claim a reverse migration restores deleted data.

## Retries and asynchronous work

Define delivery semantics and which side effects can be repeated. For operations requiring retry safety, define key scope, request fingerprint, concurrent duplicate behavior, persisted outcome, and expiry. Test crash windows and retries. Do not assume exactly-once delivery from a queue.

Set bounded timeouts, retry budgets, backoff with jitter, and handling for permanent failures. Make dead-letter inspection/replay safe and observable. Use transactional outbox/inbox patterns when consistency requirements justify them. Inspect real worker configuration and dependencies, not just unit-test behavior.

## Integrations and security

Verify signatures and replay controls for inbound callbacks where required. Define external outage behavior and mock only the external boundary. Keep secrets in the project's supported secret store; redact logs. Review dependency maintenance/license and lockfile changes. Avoid new infrastructure unless required by observed constraints.

## Operational behavior

Separate process liveness from readiness to serve traffic. Capture actionable structured errors and correlation identifiers without sensitive payloads. Monitor the user-visible operation and queue age/failure rates where applicable. State capacity assumptions; benchmark relevant limits instead of claiming arbitrary scale.
