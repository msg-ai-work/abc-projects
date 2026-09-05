# Phase 1 Runtime Test — SAMPLE-MSG-2026

## 목적
ABC Project Forge의 Core Orchestration을 Kiro IDE에서 실제 실행해 `project-config → Orchestrator → Stage Agent → Human Gate → Quality Gate` 흐름을 검증한다.

## Kiro IDE 클릭 / 명령 순서

1. Kiro IDE에서 `abc-projects` Workspace를 연다.
2. Source Control에서 `main` 브랜치인지 확인하고 최신화한다. Terminal 사용 시 `git checkout main && git pull --ff-only`.
3. Kiro Terminal에서 공통 Harness를 bootstrap 한다.
   - PowerShell: `./scripts/bootstrap-harness.ps1`
   - Bash: `bash scripts/bootstrap-harness.sh`
4. `.ai-harness/common/HARNESS.md`가 생성됐는지 확인한다.
5. 새 Chat Session을 시작한다. IDE의 `SessionStart` Hook이 `.kiro/hooks/preflight-check.json`을 통해 `scripts/preflight-check.ps1`을 실행한다.
6. Chat 입력창 하단의 현재 Agent 이름(예: `Default`)을 클릭한다.
7. Agent picker의 **Workspace** 그룹에서 `project-orchestrator`를 선택한다.
8. Chat 입력창에서 `/`를 입력해 manual Steering 목록을 열고 `/project-delivery`를 선택하거나, 아래 첫 실행 프롬프트를 그대로 입력한다.
9. 01 Intake 산출물이 생성된 뒤 `Awaiting Approval`에서 멈추는지 확인한다.
10. 사람 승인 Evidence가 없는데 02 Requirement가 실행되면 Phase 1 실패로 판정한다.

> Kiro IDE 1.x 기준 Workspace custom agent는 `.kiro/agents/`에서 로드되며, Agent picker는 Chat 입력창 하단의 Agent 이름을 클릭해 연다. `inclusion: manual` Steering은 `/` 명령 목록에 노출된다.

## 사전 준비

- `project-config.md`는 `SAMPLE-MSG-2026` Runtime Test 값으로 이미 설정되어 있다.
- 실제 고객 개인정보, Production Credential, Secret은 사용하지 않는다.
- `runtime_test.external_write_enabled: false`를 유지한다.
- Kiro Agent picker에서 `project-orchestrator`를 선택한다.

## 첫 실행 프롬프트

SAMPLE-MSG-2026 Phase 1 Runtime Test를 수행해줘.

목표는 ABC Project Forge의 Core Orchestration이 실제로 동작하는지 검증하는 것이다.

반드시 다음 순서로 수행한다.
1. `project-config.md`, `DOMAIN.md`, `harness.yaml`, `.kiro/steering/human-gates.md`, `.kiro/steering/evidence-policy.md`, `workflows/project-delivery.md`를 먼저 읽는다.
2. `scripts/preflight-check.ps1`을 실행하고 결과를 기록한다.
3. Project ID는 `SAMPLE-MSG-2026`을 사용한다.
4. `01-project-intake`를 sub-agent로 호출해 `docs/projects/SAMPLE-MSG-2026/01-PROJECT-INTAKE.md`를 생성한다.
5. 01 결과는 사람이 승인하지 않았으므로 `Awaiting Approval`까지만 허용한다.
6. 승인 전 `02-requirement`를 실행하지 말고 Human Gate에 의해 차단되었음을 명확히 보고한다.
7. AI가 `Approved` 상태나 승인자를 임의로 기록하지 않는다.
8. 이 실행에서는 Production 배포, Migration 실행, Rollback 실행, 외부 시스템 쓰기, 실제 고객 데이터 사용을 하지 않는다.
9. 종료 시 아래 표를 출력한다.

| 항목 | 결과 | Evidence |
|---|---|---|
| Preflight | PASS/WARN/FAIL | 명령 및 결과 |
| Common Harness mount | PASS/FAIL | `.ai-harness/common/HARNESS.md` |
| Orchestrator 로드 | PASS/FAIL | Agent/Resource 확인 |
| 01 Intake 호출 | PASS/FAIL | 생성 파일 |
| 01 상태 | Draft/Awaiting Approval | 파일 상태 |
| 02 사전 차단 | PASS/FAIL | Human Gate 근거 |
| Open Decision | 건수 | 항목 요약 |
| Risk | 건수 | 항목 요약 |
| 다음 Human Action | - | Scope 승인 여부 |

Phase 1 첫 실행에서는 사람 승인 없이 02 이후 단계로 진행하면 실패로 판정한다.

## 1차 검증 절차

### A. Preflight
- 필수 파일 누락 없음
- `.ai-harness/common/HARNESS.md` 존재
- `project-config.md` placeholder 없음
- 결과: `ABC Project Forge preflight: PASS`

### B. Orchestrator
- `subagent` tool 포함
- `availableAgents`에 01~07, `risk-manager`, `project-reviewer` 포함
- Project ID를 `SAMPLE-MSG-2026`으로 인식
- 산출물 SSOT가 `docs/projects/SAMPLE-MSG-2026/`

### C. Stage 01
- `01-project-intake`가 호출됨
- `templates/01-PROJECT-INTAKE.md` 계약을 따름
- In/Out Scope, Stakeholder/R&R, Constraint, Success Criteria, Dependency, Open Decision 포함
- 상태는 `Draft` 또는 `Awaiting Approval`

### D. Human Gate
- 01이 `Approved`가 아닌 상태에서 02 실행 금지
- 02 호출을 시도했을 때 중단 또는 Orchestrator 차단
- AI가 승인 상태를 직접 만들지 않음

### E. 승인 후 2차 실행
사람이 01 문서를 검토하고 승인 Evidence를 남긴 뒤 아래 프롬프트를 실행한다.

`SAMPLE-MSG-2026의 01 Project Intake가 사람에 의해 승인되었다. 승인 Evidence를 확인한 후 02 Requirement부터 05 Test Readiness까지 순차 실행하되, 각 Stage의 Human/Quality Gate를 지키고 실패 시 원인 Stage로만 되돌아가라. 승인 Evidence가 없으면 진행하지 마라.`

## Phase 1 완료 기준
- [ ] project-config 하나로 샘플 프로젝트 실행 가능
- [ ] Orchestrator가 01~07 Agent를 올바른 순서로 선택
- [ ] Stage 산출물이 Template 계약 준수
- [ ] Human Gate 이전 다음 단계 진행 차단
- [ ] Open Decision / Risk / Evidence 기록
- [ ] 승인 후 02→03→04→05 실행 가능

## Evidence 보관
Runtime 결과는 `docs/projects/SAMPLE-MSG-2026/`에 저장하고 Issue #3 댓글에 아래를 남긴다.
- 실행 일시
- Kiro IDE 버전
- Preflight 출력
- 생성된 산출물 경로
- 02 차단 여부
- 승인 후 02→05 결과
- 잔여 Risk / Open Decision

## 판정
모든 항목을 만족하면 Issue #3을 `completed`로 종료한다. Kiro 실제 sub-agent 호출 또는 Human Gate 차단 Evidence가 없으면 구조 검증만 PASS로 보고 Issue는 닫지 않는다.
