# Backend guidance evaluations

These are repeatable evaluation cases, not recorded successes. They test whether the skill supplies engineering judgment for a less experienced developer. Installer tests cannot establish this.

## How to run

Use the same agent/model, tool access, time budget, and fresh disposable project state for runs with and without the skill. Record the skill commit, model/version, prompt, environment, transcript, changes, executed checks, and unresolved gaps. Repeat runs before drawing conclusions; do not compare one favorable transcript against an unrelated baseline.

Supply only the user prompt, relevant starter project, and the skill when enabled. Keep evaluator expectations separate from the agent's task. Never supply real credentials, real user data, or production access. Use payment/provider sandboxes or controlled stubs. For existing-project cases, freeze a fixture commit and reuse it across comparisons. Do not score a case without the required fixture or environment.

## Cases

| Case | User prompt and setup | Evaluator checks |
| --- | --- | --- |
| New beginner project | Empty directory. “I want students to save private study notes. I don't know backend development. Help me build the first working part.” | Agent resolves ownership/access in understandable terms, recommends a proportionate approach, delivers creation/retrieval with persistence and forbidden-access checks, and supplies a way to try it. It does not invent unnecessary infrastructure. |
| Existing workspace API | Fixture with two workspaces and authenticated item CRUD. Seed one item per workspace. “Add a way for my dashboard to list a workspace's items.” | Agent inspects the existing auth/data model, maintains scoped results, and tests that one workspace cannot retrieve another's items. Existing stack and unrelated edits are preserved. |
| Duplicate order callback | Sandbox fixture with order creation and a controllable provider callback. “Add payment confirmation to mark my order paid.” | Agent establishes the source of truth, checks authenticity as applicable, handles repeated/concurrent callbacks and uncertain outcomes, and verifies stored state/side effects rather than promising exactly-once behavior. No real money is moved. |
| Last available seat | Fixture with persistent event capacity and two customers. “Let people reserve the last seats.” | Agent defines reservation semantics and proves competing writes cannot exceed capacity. A process-local check followed by an unprotected write is insufficient. |
| Client integration | Fixture containing a cookie-authenticated API and an existing client with different origins. “My frontend can't save notes. Make it work.” | Agent inspects the actual request/session flow, verifies the affected client path, and keeps server authorization and suitable CSRF/CORS behavior. It does not expose secrets or disable protections to hide the failure. |
| Unavailable verification | Existing backend with its integration database unavailable. “Finish this endpoint and tell me if I can launch.” | Agent completes independently verifiable work, names the blocked integration check and practical consequence, and provides a next action. It does not claim the endpoint is verified or ready based on unit tests alone. |
| Small maintenance task | Existing tested backend. “Fix this incorrect error code without changing the API behavior otherwise.” | Agent makes a localized change with relevant verification and no unnecessary architecture questionnaire, new services, or full milestone planning. |

## Scoring and evidence

For each applicable dimension score 0 (missing/harmful), 1 (described but not demonstrated), or 2 (demonstrated with artifacts/evidence):

- Relevant requirements discovered; consequential decisions handled explicitly.
- Recommendations fit the existing project and are understandable to the user.
- A complete useful operation is delivered without unnecessary complexity.
- Authorization, data integrity, and relevant failure behavior are correct.
- Verification exercises actual boundaries and reports its limits accurately.
- The user can try the result and identify the next action before release.

Report dimensions separately, along with unnecessary questions/approval requests and unsupported completion claims. Unauthorized production actions, leaked secrets, demonstrated cross-owner access, data corruption, or fabricated evidence are critical failures regardless of score. Record not-applicable dimensions with reasons. Missing environments produce incomplete evaluations, not passes.

Do not turn these scenarios into universal implementation requirements. Improve the skill based on observed failures, then rerun affected cases and check for regressions in the small-task case. This repository does not yet contain a completed comparative agent evaluation.
