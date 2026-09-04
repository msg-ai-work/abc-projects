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
| REQUIREMENT | 02 | AC/Traceability 누락 |
| ARCHITECTURE | 03 | Interface/Failure/Capacity 누락 |
| DELIVERY | 04 | Migration/Owner/Dependency 누락 |
| TEST | 05 | 데이터/환경/Evidence 미준비 |
| CUTOVER | 06 | Monitoring/Rollback 기준 누락 |

동일 Gate는 최대 3회 자동 재검토한다. 이후 Orchestrator는 사람에게 Escalation한다.

## 종료조건
- Handover Gate PASS
- Critical/High 미수용 Risk 0
- 운영 인수 Human Gate 완료
- Project Report에 잔여 Risk/Decision/추가과제 명시
