# Quality Gate Regression Fixtures

Issue #4 Phase 2의 L4 Quality Gate를 재현 가능하게 검증하는 실패 Fixture입니다.

| Case | 대상 | 기대 FAIL CODE | 결함 |
|---|---|---|---|
| case-001-requirement | 02 Requirement | REQUIREMENT | Acceptance Criteria 누락 |
| case-002-architecture | 03 Architecture/Integration | ARCHITECTURE | Timeout/Retry/Idempotency 누락 |
| case-003-delivery | 04 Delivery | DELIVERY | Dependency/담당자/Due Date 누락 |
| case-004-test | 05 Test Readiness | TEST | Threshold 누락 |
| case-005-cutover | 06 Cutover | CUTOVER | Rollback Trigger 누락 |

## 실행

```powershell
./scripts/run-quality-gate-evals.ps1
```

각 Case는 정상이라면 `quality-gate.ps1`이 exit code 1을 반환하고, 출력에 기대 FAIL CODE가 포함되어야 합니다. Fixture가 PASS하면 회귀 실패입니다.
