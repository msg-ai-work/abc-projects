# Phase 5 Runtime Test — Seven-Stage Evals

## 목적
01 Project Intake부터 07 Handover까지 모든 Stage에 대해 정상/실패 사례를 동일한 Quality Gate로 반복 검증한다.

## 실행

```powershell
pwsh -NoProfile -File scripts/run-stage-evals.ps1
```

통합 Regression:

```powershell
pwsh -NoProfile -File scripts/run-forge-regression.ps1
```

Worktree까지 포함한 전체 검증:

```powershell
pwsh -NoProfile -File scripts/run-forge-regression.ps1 -IncludeWorktree
```

## Fixture 계약

`evals/stages/*.json` 7개 파일이 각각 PASS/FAIL 두 사례를 제공한다. 총 14 cases이다.

| Stage | PASS 조건 핵심 | FAIL 기대 코드 |
|---|---|---|
| 01 Intake | In/Out Scope, Stakeholder, Success Criteria, Open Decision | SCOPE |
| 02 Requirement | REQ ID, Acceptance Criteria | REQUIREMENT |
| 03 Architecture | Timeout, Retry, Idempotency | ARCHITECTURE |
| 04 Delivery | Dependency, 담당자, Due Date | DELIVERY |
| 05 Test | Traceability, Environment, Threshold, Evidence | TEST |
| 06 Cutover | Go/No-Go, Monitoring, Rollback Trigger | CUTOVER |
| 07 Handover | Runbook, Incident, Permission, Known Issue, Training, Support, Human Acceptance | HANDOVER |

## PASS 기준

- 7개 Positive Fixture 모두 exit code 0
- 7개 Negative Fixture 모두 exit code 1
- 각 Negative Fixture가 자신의 기대 Gate Code를 포함
- 총 결과 `Seven-stage evals: PASS (14/14 cases)`

## CI

`.github/workflows/forge-regression.yml`이 PR과 main push에서 다음을 수행한다.
1. 기존 Quality Gate 실패 Fixture 5종
2. 3회 Rework + 4번째 Escalation 정책
3. 7-Stage PASS/FAIL 14 cases
4. 2-Worktree 격리 Runtime Test

CI가 실패하면 해당 PR은 Forge 품질 회귀가 있는 것으로 간주한다.

## 다음 Metrics

CI 실행부터 아래 값을 월별로 축적한다.
- Gate Pass Rate / First Pass Yield
- Gate Code별 실패 건수
- Rework 횟수 및 REWORK_LIMIT 발생 건수
- Requirement→TC Traceability Coverage
- Worktree/PR Gate 실패 건수
- Phase별 Runtime Test PASS율
