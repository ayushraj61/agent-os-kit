# System Architecture & Technical Invariants

*This document is the authoritative source of truth for high-level system topology, non-negotiable architectural boundaries, and technology decisions. Agents must read this before proposing architectural changes.*

---

## 0. Product Boundary (What We Do vs. What We Never Do)
*Define the hard boundaries of your product here so AI agents do not hallucinate out-of-scope features.*

- **Core Functionality:** [Example: High-throughput ingestion API and indexed retrieval service.]
- **Explicit Non-Goals:** [Example: We do not orchestrate autonomous agents; we provide reliable infrastructure only.]
- **Forbidden Patterns:** [Example: No synchronous HTTP calls in background worker loops; no raw vector columns without versioning.]

---

## 1. Technical Stack & Invariants

| Layer | Technology | Primary Invariant / Rule |
| :--- | :--- | :--- |
| **API Framework** | [e.g. FastAPI / Express / Go] | Strict schema validation; OpenAPI typed contracts. |
| **Primary Database** | [e.g. PostgreSQL 16+] | Relational integrity, foreign keys, migrations via code. |
| **Cache / Queue** | [e.g. Redis + Celery / BullMQ] | At-least-once delivery; all consumers must be idempotent. |
| **Containerization** | [e.g. Docker Compose] | Dev environment mirrors production ports and services. |

---

## 2. Multi-Tenancy & Data Isolation Model
*(If single-tenant, state that clearly. If multi-tenant, define the rules below.)*

- **Tenant Key:** `org_id` / `tenant_id` must exist on every tenant-owned table.
- **Composite Isolation:** Foreign keys between tenant-owned entities MUST be composite:
  ```sql
  -- Example of enforced tenant isolation:
  FOREIGN KEY (tenant_id, resource_id) REFERENCES resources (tenant_id, id)
  ```
- **Query Scoping:** Never rely on bare application-level filtering without database constraints.

---

## 3. Database & Concurrency Rules

1. **Atomic Sequence Guarantees:** Counters and sequence numbers must be allocated atomically via database locks or row updates (`UPDATE ... RETURNING`), never via un-synchronized in-memory state.
2. **Idempotency Invariant:** Any mutation endpoint (e.g., `POST /v1/transfers`, `POST /v1/send`) must support an `Idempotency-Key` header stored in an `idempotency_keys` table.
3. **Migration Policy:** 
   - No destructive migrations on tables holding production data.
   - Every forward migration must have a tested, clean rollback script.

---

## 4. Future Upgrade Triggers
*List major architectural transitions and the quantitative conditions required before an agent is allowed to propose them.*

- **Example — Migration from PostgreSQL Queue to Kafka/RabbitMQ:**
  - *Trigger Condition:* Worker queue latency exceeds 500ms under sustained load (>10,000 tasks/min) or database write IOPS exceed 80% capacity.
  - *Rule:* Do not propose Kafka before this quantitative metric is verified in production logs.
