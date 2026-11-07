# Backend feature: <name>

Status: Draft / approved / implemented / verified (choose with evidence).

## Outcome and scope
Caller, product operation, current behavior, desired outcome, and non-goals.

## Contract and access
Inputs, outputs, errors, compatibility, authentication, authorization, and data ownership.

## Data and execution
Affected schema/constraints, transaction boundaries, concurrent behavior, migration and deployment compatibility. Include workers/integrations only where relevant.

## Hidden requirements and decisions
Trace caller → validation/access → state change → external effects → response → recovery. Record applicable risks (for example duplicate work, forbidden access, or concurrent updates), required safeguards, unresolved product decisions, and deferred improvements. Omit irrelevant mechanisms.

## Failure and recovery
Timeouts, invalid requests, dependency failures, retry/duplicate semantics, and recovery strategy appropriate to this change.

## Acceptance and verification
Observable success and denial/failure criteria; relevant unit/integration/manual checks, environment requirements, and evidence links. Record unverified criteria explicitly.

## Client integration (when affected)
Request/response example, authentication/session behavior, error states, and compatibility with existing callers. Keep privileged checks and secrets server-side.

## Rollout and decisions
Operational signals, rollout/recovery steps if needed, assumptions, trade-offs, and unresolved decisions.
