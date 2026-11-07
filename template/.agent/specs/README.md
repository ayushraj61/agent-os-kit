# Specifications Directory

**Rule: No Spec, No Implementation.**

Before an AI agent or developer writes production code for any feature touching more than one file, a database schema, or an API contract:
1. Copy `00_template_spec.md` to `[feature_name].md`.
2. Define the exact **Goal**, **Inputs & Outputs**, **Edge Cases**, and **Invariants**.
3. Link the spec section in `.agent/TASKS.md`.
4. Only then begin implementation.

