# Testing Evidence & Regression Matrix

> **Rule:** No Evidence, No Done. Never mark a task `[x] DONE` in `TASKS.md` without recording terminal execution output, pass/fail counts, and the exact command below.

---

## 1. Regression Test Commands

| Scope | Command | Purpose |
| :--- | :--- | :--- |
| **Unit Tests** | `pytest tests/unit -q` | Fast feedback loop (<5s) |
| **Integration** | `pytest tests/integration -q` | Database and container interactions |
| **Lint / Typecheck** | `ruff check . && mypy .` | Static analysis & type safety |
| **Full Suite** | `pytest -q` | Full regression before phase transition |

---

## 2. Test Execution Evidence Log

### Task 1.1: Database Schema Bootstrap
- **Date:** 2026-11-07
- **Command:** `alembic upgrade head && pytest tests/test_migrations.py -q`
- **Result:** PASS
- **Evidence:**
```text
INFO  [alembic.runtime.migration] Running upgrade  -> a1b2c3d4, initial schema
.                                                                        [100%]
1 passed in 0.42s
```

*(Append new evidence blocks chronologically as tasks complete.)*

