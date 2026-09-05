---
inclusion: always
---
# Rework / Escalation Policy

Quality Gate 실패는 아래 표준 코드와 재작업 Agent로 분류한다.

| Gate Code | Rework Agent |
|---|---|
| SCOPE | 01-project-intake |
| REQUIREMENT | 02-requirement |
| ARCHITECTURE | 03-architecture |
| DELIVERY | 04-delivery-plan |
| TEST | 05-test-readiness |
| CUTOVER | 06-cutover |
| HANDOVER | 07-handover |

## 반복 규칙

- 최초 Gate 실패 후 동일 Gate의 `failure_count=1`이면 Rework 1회차를 수행한다.
- `failure_count=2`이면 Rework 2회차를 수행한다.
- `failure_count=3`이면 Rework 3회차를 수행한다.
- 동일 Gate가 다시 실패해 `failure_count=4`가 되면 더 이상 sub-agent를 자동 호출하지 않는다.
- 4번째 실패부터 Decision은 `ESCALATE`, Fail Code는 `REWORK_LIMIT`으로 보고한다.
- Escalation 시 현재 산출물, 마지막 Gate 실패 근거, 3회 재작업 이력, Open Decision/Risk, 필요한 Human Action을 남긴다.
- 사람이 명시적으로 다음 조치를 결정하기 전 AI는 추가 재작업, 승인, Production 실행을 진행하지 않는다.

## 출력 계약

Orchestrator는 반복마다 다음 필드를 추적한다.

| Field | 설명 |
|---|---|
| gate_code | 실패 Gate 코드 |
| rework_agent | 재실행 Agent |
| failure_count | 동일 Gate 누적 실패 횟수 |
| max_reworks | 3 |
| decision | REWORK 또는 ESCALATE |
| evidence | 실패 근거 |
| next_human_action | 사람의 다음 결정이 필요한 경우 명시 |
