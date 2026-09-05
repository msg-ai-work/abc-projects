# ABC Project Forge — 70% 구현 로드맵

기준일: 2026-09-05

## 목표

구조 존재 여부가 아니라 `자동검증 + Runtime Evidence + 반복 측정`을 기준으로 전체 구현 진척률을 약 70%까지 끌어올린다.

## 이번 변경 후 예상 기준선

| Phase | 가중치 | 변경 후 수준 | 가중 반영 | 핵심 상태 |
|---|---:|---:|---:|---|
| Phase 1 Core Orchestration | 25% | 70% | 17.50% | 구조/Runtime 절차 구현, 실제 Kiro sub-agent Evidence 필요 |
| Phase 2 Quality/Rework | 25% | 70% | 17.50% | 7-Stage Gate + 3회 Rework 정책 + CI Regression 구현 |
| Phase 3 Worktree/PR | 20% | 55% | 11.00% | 2-Worktree 격리 Runtime Script/CI 구현, 실제 PR 생성 Evidence 필요 |
| Phase 4 Jira/Confluence | 15% | 20% | 3.00% | 설정 구조만 존재, 실제 Context 연계 필요 |
| Phase 5 Evals/Metrics | 15% | 55% | 8.25% | 14개 Stage Eval + CI 구현, 월별 Metrics 축적 필요 |
| **전체** | **100%** |  | **57.25%** | **반올림 57%** |

## 70% 목표 상태

| Phase | 목표 | 가중 반영 |
|---|---:|---:|
| Phase 1 | 90% | 22.50% |
| Phase 2 | 80% | 20.00% |
| Phase 3 | 65% | 13.00% |
| Phase 4 | 25% | 3.75% |
| Phase 5 | 70% | 10.50% |
| **전체** |  | **69.75% ≒ 70%** |

## 실행 순서

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
- 실제 Kiro sub-agent 호출 로그
- `docs/projects/SAMPLE-MSG-2026/` 산출물
- Human Gate 차단 Evidence
- 승인 후 Stage 진행 Evidence

### Step 2 — Phase 2 Rework Runtime
목표: Phase 2 70% → 80%

실행:
```powershell
pwsh -NoProfile -File scripts/run-rework-loop-eval.ps1
```
그리고 Kiro에서 `docs/PHASE2-REWORK-RUNTIME-TEST.md` 절차 수행.

완료조건:
- failure_count 1~3 = REWORK
- failure_count 4 = REWORK_LIMIT / ESCALATE
- 4번째 실패에서 sub-agent 자동 호출 없음
- Issue #4 Evidence 등록

### Step 3 — Phase 3 Worktree Runtime
목표: Phase 3 55% → 65%

실행:
```powershell
pwsh -NoProfile -File scripts/run-worktree-isolation-test.ps1
```

완료조건:
- Worktree 2개 동시 생성
- 변경 격리 PASS
- Quality Gate 실패 시 PR 전 차단
- dirty cleanup 차단
- clean cleanup PASS
- 이후 `/project-pr`로 실제 테스트 PR 1건 생성/검토/병합 Evidence

### Step 4 — Phase 4 최소 Read-Only Context Smoke Test
목표: Phase 4 20% → 25%

완료조건:
- 테스트 Jira Key 1개 Read
- Confluence 테스트 문서 1개 Read
- Token/Secret 미저장
- 외부 Write 없음
- Requirement/Evidence에 출처 링크만 연결

### Step 5 — Phase 5 Eval + Metrics Baseline
목표: Phase 5 55% → 70%

실행:
```powershell
pwsh -NoProfile -File scripts/run-stage-evals.ps1
pwsh -NoProfile -File scripts/run-forge-regression.ps1
```

완료조건:
- 14/14 Stage Eval PASS
- GitHub Actions Regression PASS
- Gate Pass Rate / Rework / Runtime PASS율 월별 기준선 생성
- Skill/Agent 변경 PR에 Regression 결과 첨부

## 70% 진입 Gate

다음 다섯 Evidence가 모두 있으면 전체 약 70%로 판정한다.

1. Kiro Phase 1 Runtime PASS
2. Rework Loop 3회 + Escalation PASS
3. Worktree Isolation + 실제 테스트 PR Evidence
4. Jira/Confluence Read-only Context Smoke Test
5. 7-Stage 14/14 Eval + GitHub Actions PASS + 첫 Metrics 기준선

## 이후 70% → 90%

- 실제 프로젝트 2개 이상 Forge 적용
- CI Regression을 모든 Harness/Skill 변경 PR의 필수 Check로 지정
- 월별 Cycle Time / First Pass Yield / Rework 추세 관리
- Jira Requirement ↔ GitHub PR ↔ TC ↔ Evidence Traceability 자동화
- Production 전환/원복 Human Gate의 운영 Evidence 축적
