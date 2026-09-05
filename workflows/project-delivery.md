# ABC Project Forge - Project Delivery Workflow

## 목적
사용자 요청 하나를 Project Intake부터 Handover까지 단계적 산출물, Quality Gate, Human Gate, 재작업 Loop로 연결한다.

## Stage DAG

```text
00 Preflight
  ↓
01 Project Intake ──[Human: Scope 승인]
  ↓
02 Requirement ─────[Human: 요구 승인]
  ↓
03 Architecture + Integration ──[Human: 기준선 승인]
  ↓
04 Delivery + Migration + Risk
  ↓
05 Test Readiness
  ├─ PASS → 06
  └─ FAIL → 원인 Stage로 최대 3회 Loop
  ↓
06 Cutover + Rollback ──[Human: Go/No-Go, Production]
  ↓
07 Handover ────────────[Human: 운영 인수]
```

## 00 Preflight
- project-config.md 존재/placeholder 여부
- `.ai-harness/common/HARNESS.md` mount 여부
- 10개 local Skill 존재
- Git 상태와 base branch 확인
- MCP는 사용 가능 여부만 확인하며 Token 값을 출력하지 않는다.

## 01~07 공통 계약
각 Stage는 `Input → Agent → Output → Quality Gate → Human Gate → Next`를 가진다. Agent 결과는 `docs/projects/<project-id>/`에 저장한다.

## 재작업 분류
| FAIL 코드 | 재실행 Agent | 예 |
|---|---|---|
| SCOPE | 01-project-intake | In/Out Scope, Success Criteria 누락 |
| REQUIREMENT | 02-requirement | AC/Traceability 누락 |
| ARCHITECTURE | 03-architecture | Interface/Failure/Capacity 누락 |
| DELIVERY | 04-delivery-plan | Migration/담당자/Dependency 누락 |
| TEST | 05-test-readiness | 데이터/환경/Evidence 미준비 |
| CUTOVER | 06-cutover | Monitoring/Rollback 기준 누락 |
| HANDOVER | 07-handover | Runbook/Alarm/권한/교육 Evidence 누락 |

동일 Gate의 `failure_count=1~3`은 지정 Agent로 재작업한다. 동일 Gate가 4번째 실패하면 자동 재작업을 중단하고 `REWORK_LIMIT / ESCALATE`로 사람에게 이관한다. 상세 계약은 `.kiro/steering/rework-policy.md`를 따른다.

## 종료조건
- Handover Gate PASS
- Critical/High 미수용 Risk 0
- 운영 인수 Human Gate 완료
- Project Report에 잔여 Risk/Decision/추가과제 명시
