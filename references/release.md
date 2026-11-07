# Backend release readiness

Apply relevant checks for a requested release or readiness review. Record evidence or a reason each item is not applicable. Do not deploy merely because this checklist exists.

- Core user operation works through the real API and persistence boundary in a representative environment.
- Authorization and tenant denial paths are demonstrated; exposed input and resource consumption are bounded.
- Schema changes remain compatible during rollout; backfill/locking risks and recovery are understood.
- Retries, dependency outages, duplicate work, and worker crashes have defined outcomes for affected paths.
- Required configuration is validated; secrets are provided securely; application and worker versions/configurations agree.
- CI checks and an artifact/version identify what will ship. Health/readiness, logs, and actionable alerts cover important failures.
- Deployment rollback or forward recovery is documented. Backups and restoration are verified where persistent data requires them.
- Relevant load/latency checks match expected usage; cost and capacity assumptions are explicit.
- Remaining risks, ownership, and any required release decision are reported. Unverified items prevent an unqualified readiness claim.
