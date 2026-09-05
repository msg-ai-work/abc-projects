# ABC Project Forge — 70% 구현 로드맵

기준일: 2026-09-05

## 목표

구조 존재 여부가 아니라 `자동검증 + Runtime Evidence + 반복 측정`을 기준으로 전체 구현 진척률을 약 70%까지 끌어올린다.

## 현재 기준선 — CI 실행 후

GitHub Actions `Forge Regression` Run `33940716835`에서 다음이 실제 PASS했다.
- Quality Gate negative fixtures 5/5
- Rework Loop: 1~3 REWORK, 4 ESCALATE/REWORK_LIMIT
- Seven-stage Evals 14/14
- Parallel Worktree Isolation / Gate Block / Dirty Cleanup Guard / Safe Cleanup

상세 Evidence: `docs/evidence/FORGE-REGRESSION-2026-09-05.md`

| Phase | 가중치 | 현재 수준 | 가중 반영 | 핵심 상태 |
|---|---:|---:|---:|---|
| Phase 1 Core Orchestration | 25% | 70% | 17.50% | 구조/Runtime 절차 구현, 실제 Kiro sub-agent Evidence 필요 |
| Phase 2 Quality/Rework | 25% | 75% | 18.75% | Quality/Rework CI PASS, 실제 Kiro Rework sub-agent Evidence 필요 |
| Phase 3 Worktree/PR | 20% | 60% | 12.00% | 2-Worktree 격리 CI PASS, 실제 `/project-pr` 생성 Evidence 필요 |
| Phase 4 Jira/Confluence | 15% | 20% | 3.00% | 설정 구조만 존재, 실제 Context 연계 필요 |
| Phase 5 Evals/Metrics | 15% | 60% | 9.00% | 14/14 CI PASS, 월별 Metrics/변경 전후 비교 필요 |
| **전체** | **100%** |  | **60.25%** | **반올림 60%** |

## 70% 목표 상태

| Phase | 목표 | 가중 반영 |
|---|---:|---:|
| Phase 1 | 90% | 22.50% |
| Phase 2 | 80% | 20.00% |
| Phase 3 | 65% | 13.00% |
| Phase 4 | 25% | 3.75% |
| Phase 5 | 70% | 10.50% |
| **전체** |  | **69.75% ≒ 70%** |

## 남은 실행 순서

### Step 1 — Phase 1 Kiro Runtime Evidence 확보
목표: Phase 1 70% → 90%

실행:
```text
project-orchestrator 선택
→ SAMPLE-MSG-2026 첫 실행
→ 01 Intake 생성
→ Awaiting Approval 확인
→ 승인 전 02 차단 Evidence
→ 사람 승인 후 02~05 실행
```

완료조건:
- 실제 Kiro custom sub-agent 호출 로그
- `docs/projects/SAMPLE-MSG-2026/` 산출물
- Human Gate 차단 Evidence
- 승인 후 Stage 진행 Evidence

### Step 2 — Phase 2 Kiro Rework Runtime
목표: Phase 2 75% → 80%

PowerShell/CI 정책 검증은 완료됐다. 남은 것은 Kiro Orchestrator 실제 동작 Evidence다.

실행 문서: `docs/PHASE2-REWORK-RUNTIME-TEST.md`

완료조건:
- Kiro에서 failure_count 1~3마다 `03-architecture` 재작업 선택
- 4번째 동일 실패에서 sub-agent 자동 재호출 없음
- `REWORK_LIMIT / ESCALATE` 출력
- Issue #4에 실행 Evidence 등록

### Step 3 — Phase 3 실제 `/project-pr` Evidence
목표: Phase 3 60% → 65%

Worktree 격리/cleanup CI 검증은 완료됐다. 남은 것은 실제 PR Workflow다.

완료조건:
- 테스트 Worktree에서 변경 Commit/Push
- `/project-pr`로 테스트 PR 1건 생성
- PR Body에 Project ID / Gate / Risk / Decision 포함
- Review/Merge 후 Worktree cleanup
- Issue #5 Evidence 등록

### Step 4 — Phase 4 최소 Read-Only Context Smoke Test
목표: Phase 4 20% → 25%

완료조건:
- 테스트 Jira Key 1개 Read
- Confluence 테스트 문서 1개 Read
- Token/Secret Repository 미저장
- 외부 Write 없음
- Requirement/Evidence에 출처 연결

### Step 5 — Phase 5 첫 Metrics Baseline
목표: Phase 5 60% → 70%

7-Stage 14/14와 CI Regression은 완료됐다.

`templates/FORGE-METRICS-MONTHLY.md`를 사용해 첫 월 기준선을 작성한다.

최소 기록:
- 7-Stage Eval Pass Rate = 100%
- Quality Gate negative fixture = 5/5
- Rework policy regression = PASS
- Worktree Isolation = PASS
- REWORK_LIMIT 발생 건수
- 향후 Skill/Agent 변경 전/후 Regression 비교 기준

## 70% 진입 Gate

다음 남은 Evidence를 확보하면 전체 약 70%로 판정한다.

1. Kiro Phase 1 Runtime PASS
2. Kiro Rework Loop 실제 sub-agent/Escalation Evidence
3. 실제 `/project-pr` 테스트 PR Evidence
4. Jira/Confluence Read-only Context Smoke Test
5. 첫 Forge Monthly Metrics Baseline

## 이후 70% → 90%

- 실제 프로젝트 2개 이상 Forge 적용
- CI Regression을 모든 Harness/Skill 변경 PR의 required check로 지정
- 월별 Cycle Time / First Pass Yield / Rework 추세 관리
- Jira Requirement ↔ GitHub PR ↔ TC ↔ Evidence Traceability 자동화
- Production 전환/원복 Human Gate의 운영 Evidence 축적
