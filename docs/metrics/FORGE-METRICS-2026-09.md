# Forge Monthly Metrics Baseline — 2026-09

기준일: 2026-09-05

## 목적

ABC Project Forge의 첫 월간 정량 기준선이다. `AI 사용량`이 아니라 Gate 품질, Rework, Runtime 검증, PR 안전성을 측정한다.

## Baseline KPI

| Metric | Baseline | Evidence |
|---|---:|---|
| Seven-stage Eval Pass Rate | 100% (14/14) | Forge Regression CI |
| Quality Gate Negative Fixture Detection | 100% (5/5) | Forge Regression CI |
| Rework Policy Regression | PASS | failure_count 1~3=REWORK, 4=ESCALATE/REWORK_LIMIT |
| Parallel Worktree Isolation | PASS | 2 Worktrees isolated |
| Dirty Worktree Cleanup Guard | PASS | dirty cleanup blocked |
| Safe Worktree Cleanup | PASS | clean worktrees/local branches removed |
| Actual GitHub PR E2E | PASS | PR #14 Branch→Commit→PR→CI→Merge |
| Critical/High Risk Auto-Accept | 0 permitted | Human Gate policy |
| Production execution in regression | 0 | test-only scope |
| Customer data used in regression | 0 | synthetic/test evidence only |

## Runtime Evidence

### Forge Regression
- Workflow: `Forge Regression`
- Reference evidence: `docs/evidence/FORGE-REGRESSION-2026-09-05.md`
- Result: SUCCESS

### Phase 3 PR E2E
- Project ID: `PR-E2E-20260905`
- PR: #14
- Branch: `project/PR-E2E-20260905/forge-pr-smoke`
- CI: Forge Regression PASS
- Merge commit: `18d61049ce49fbbf33c9b1b15e6f24c39079468a`
- Production impact: none

## 아직 측정 불가한 지표

다음은 실제 Kiro 프로젝트 Runtime 또는 운영 데이터가 누적된 후 측정한다.

| Metric | Current status |
|---|---|
| Intake→Requirement Human Approval Lead Time | Kiro Runtime Evidence 필요 |
| Stage별 First Pass Yield | 실제 프로젝트 실행 데이터 필요 |
| 실제 Rework 횟수/원인 분포 | Kiro Runtime Evidence 필요 |
| Requirement→TC Traceability Coverage | 실제 프로젝트 산출물 필요 |
| High/Critical Risk 조기 발견율 | 실제 프로젝트 2건 이상 필요 |
| AI 작업시간 대비 Human Decision Time | 운영 측정 필요 |

## 2026-09 Target

1. Kiro `SAMPLE-MSG-2026` Phase 1 Runtime Evidence 확보
2. 실제 Kiro Rework Loop / REWORK_LIMIT Evidence 확보
3. Jira/Confluence Read-only Context Smoke Test 1건
4. 실제 프로젝트 1건에 Forge 적용 시작
5. 다음 Skill/Agent 변경 PR에서 본 Baseline 대비 Regression 결과 비교

## 판정

2026-09의 최초 Baseline은 **Regression 품질과 GitHub PR 안전흐름은 측정 가능 상태**, Kiro 실제 Orchestration 생산성 지표는 아직 수집 전 상태로 본다.
