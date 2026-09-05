# Forge Regression CI Evidence — 2026-09-05

## Execution

- GitHub Actions Workflow: `Forge Regression`
- Run ID: `33940716835`
- Job ID: `101237477052`
- Pull Request: #13
- Runner: Ubuntu 24.04
- PowerShell: 7.6.5
- Result: **SUCCESS**

## Phase 2 — Quality Gate Negative Fixtures

```text
PASS case-001-requirement -> expected [REQUIREMENT] failure detected
PASS case-002-architecture -> expected [ARCHITECTURE] failure detected
PASS case-003-delivery -> expected [DELIVERY] failure detected
PASS case-004-test -> expected [TEST] failure detected
PASS case-005-cutover -> expected [CUTOVER] failure detected
Quality gate evals: PASS (5/5)
```

## Phase 2 — Rework Loop

```text
PASS failure_count=1 decision=REWORK fail_code=ARCHITECTURE
PASS failure_count=2 decision=REWORK fail_code=ARCHITECTURE
PASS failure_count=3 decision=REWORK fail_code=ARCHITECTURE
PASS failure_count=4 decision=ESCALATE fail_code=REWORK_LIMIT
Rework loop eval: PASS (3 reworks + 4th failure escalation)
```

## Phase 5 — Seven-Stage Evals

```text
PASS 01-intake positive fixture
PASS 01-intake negative fixture -> [SCOPE]
PASS 02-requirement positive fixture
PASS 02-requirement negative fixture -> [REQUIREMENT]
PASS 03-architecture positive fixture
PASS 03-architecture negative fixture -> [ARCHITECTURE]
PASS 04-delivery positive fixture
PASS 04-delivery negative fixture -> [DELIVERY]
PASS 05-test-readiness positive fixture
PASS 05-test-readiness negative fixture -> [TEST]
PASS 06-cutover positive fixture
PASS 06-cutover negative fixture -> [CUTOVER]
PASS 07-handover positive fixture
PASS 07-handover negative fixture -> [HANDOVER]
Seven-stage evals: PASS (14/14 cases)
Forge regression: PASS (IncludeWorktree=False)
```

## Phase 3 — Parallel Worktree Isolation

Runtime created two independent branches/worktrees:

```text
project/WT-A-20260905030228454/alpha
project/WT-B-20260905030228454/beta
```

Results:

```text
PASS isolation: two worktrees do not share uncommitted changes
PASS PR precondition: invalid artifact is blocked by Quality Gate
PASS cleanup guard: dirty worktree was not removed
Removed worktree and local branch: project/WT-A-20260905030228454/alpha
Removed worktree and local branch: project/WT-B-20260905030228454/beta
Worktree isolation eval: PASS (2 worktrees + gate block + dirty cleanup guard + safe cleanup)
```

## Interpretation

This CI run provides executable evidence for:
- Quality Gate defect classification
- deterministic 3-Rework/4th-Escalation policy
- all seven Stage PASS/FAIL Gate classifications
- two simultaneous Worktree isolation
- Quality Gate blocking before PR workflow
- dirty Worktree cleanup protection
- safe cleanup of clean Worktrees/local branches

It does **not** replace the remaining Kiro IDE Runtime Evidence for actual custom sub-agent invocation/Human Gate behavior, nor the Phase 3 real `/project-pr` Push/PR/Merge evidence, nor Jira/Confluence read-only context evidence.
