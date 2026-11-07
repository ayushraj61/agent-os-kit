# Guided backend delivery

Use this guide when a developer brings a product idea, lacks backend knowledge, or needs a path from a working prototype to real users. For a narrow maintenance task, use only the relevant parts. Keep the main focus on backend behavior; include frontend integration when it affects that behavior.

## Translate intent into decisions

Do not ask a beginner to design the architecture before helping them. Inspect existing code first. Ask a small batch of plain-language questions about unresolved product behavior, for example:

- Who uses this operation, and whose information may they see or change?
- What must happen when it succeeds? What would be unacceptable to lose, duplicate, or expose?
- Is this a new prototype or an application already used by people? Are there existing clients or data to preserve?
- What usage, hosting budget, or external services are already known?

Ask only what matters to the current slice; do not turn these into a mandatory questionnaire. Offer a recommendation when the user does not know. Translate mechanisms into consequences: “Only the workspace owner may invite members” before discussing roles or policies. Do not silently choose who gets access, how money moves, or when data is deleted. Record unresolved consequential decisions; use clearly labeled assumptions for reversible implementation details.

For a material technical choice explain: recommended approach, the requirement it serves, why it fits this project, and the condition that would justify revisiting it. Avoid asking the user to choose between unfamiliar technology names without guidance. Respect an explicit stack choice unless evidence shows a concrete conflict.

## Discover requirements the user did not name

For each affected operation, trace caller → validation/access → state change → external side effects → response → recovery. Identify relevant failure or abuse paths before implementing. Use this table as prompts, not as a requirement to add every mechanism.

| Feature signal | Questions the agent should investigate | Observable check |
| --- | --- | --- |
| Accounts, roles, or shared workspaces | Who owns the resource? Can a user read/change another user's or workspace's data? How are sessions revoked if required? | Attempt forbidden reads and writes; confirm denial and unchanged state. |
| Payments, orders, or external callbacks | Can retries duplicate a charge or order? Is callback authenticity verified? Which system is authoritative? | Repeat a request/event in a sandbox; inspect stored state and side effects. |
| Inventory, seats, credits, or quotas | What happens when two requests compete for the last item or balance? | Concurrent requests preserve the agreed limit and transaction outcome. |
| Uploads or generated downloads | Who can access the object? What limits apply? Can names, content, or URLs escape intended storage/access boundaries? | Reject oversized/unauthorized input and deny access to another owner's object. |
| Queues, emails, or scheduled jobs | What if a worker crashes after the side effect? Can work be retried or replayed safely? | Simulate the relevant crash/retry boundary and observe the agreed duplicate/failure behavior. |
| Lists, search, or exports | Are all results access-scoped? Can requests exhaust memory, time, or external-service spend? | Test scoped results and bounded pagination/export behavior. |
| Schema changes with existing data | Do old and new application versions coexist? Are backfills/locks and recovery understood? | Verify migration compatibility with representative data in a safe environment. |
| Third-party calls | What does a timeout mean? Is the outcome unknown? Are retries safe? | Exercise timeout, rejection, and recovery without leaking credentials. |

Classify findings as required for the requested behavior, a blocking product decision, or a later improvement. Implement necessary safeguards within authorized scope; ask before changing agreed behavior. Do not silently add payments, multi-tenancy, Redis, a queue, or another service because it appears in this table.

## Deliver one real operation at a time

For a new backend, recommend the simplest architecture that meets known constraints. Prefer the existing stack and one deployable service when suitable; justify extra services with an actual requirement. Avoid implementing authentication/cryptography primitives from scratch where suitable established capabilities are available. Do not claim a design supports a scale that has not been measured.

Choose the smallest useful journey, such as “a signed-in owner creates a private item and can retrieve it; another account cannot.” Implement the contract, persistence, authorization, relevant failure path, and tests together. The user should be able to exercise a real operation after the slice rather than receive several unfinished layers.

For larger work, use these stages only when useful:

1. **Understand:** Establish the operation, ownership, constraints, existing state, and acceptance criteria.
2. **Make one slice work:** Implement it locally with real persistence/integration boundaries where applicable. Provide a reproducible command or short walkthrough with safe sample data.
3. **Prove its boundaries:** Exercise denial, invalid input, concurrency, retries, and dependency failure where relevant. Expand only after resolving failures in the slice.
4. **Prepare for users:** Verify deployment configuration, operational signals, migration/recovery, and expected usage in the intended environment. Release actions require their own authorization.

A small fix does not need four phases or a new planning document. Reuse project tests and documentation; add tests for meaningful behavior, not to satisfy a count.

## Keep the frontend boundary usable

When a client exists, inspect its actual API calls, authentication/session mechanism, and expected errors before changing contracts. Supply a concrete request/response example and document compatibility changes. Consider loading, empty, validation, expired-session, forbidden, and server-error states that follow from the API. Verify the available client integration path when affected.

Keep secrets and privileged access checks on the server. Configure CORS/CSRF protections for the actual authentication and deployment model; do not use permissive settings simply to make the UI work. Avoid aesthetic redesign or selecting a frontend framework unless requested.

## Make progress and readiness understandable

Explain decisions at the point they matter, in plain language and without a lecture. Do not assume the user wants less detail because they are a student; adapt to their questions. Keep the workflow active rather than assigning all engineering decisions back to them.

Report each claimed level separately, scoped to the feature and environment:

| Claim | Evidence needed |
| --- | --- |
| Implemented | The code/configuration exists; state which checks remain. This does not imply it runs. |
| Works locally | The operation was exercised successfully in the stated local environment. |
| Verified for the stated scope | Acceptance criteria and relevant denial/failure checks passed, with reproducible evidence. Mocked external services and missing checks are disclosed. |
| Ready for the intended release | Relevant deployment, security, migration/recovery, and operational checks are evidenced in a representative target environment; no release-blocking gap remains. This is not a promise of zero failures. |

Do not automatically promote a feature because unit tests passed or a health endpoint responds. Distinguish an unavailable check from a failing check. For each significant gap explain what could go wrong for users, the next concrete action, and whether it blocks the intended release. Prepare everything that can be verified independently while a missing credential or product decision blocks another part.

A completion report should let the developer answer: What works now? How do I try it? What proved it? What remains before real users? Link evidence instead of repeating logs. Record the next useful action so another session can continue without guessing.
