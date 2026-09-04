---
inclusion: always
---
# Project Forge Chain

기본 단계는 `01 Intake → 02 Requirement → 03 Architecture/Integration → 04 Delivery/Migration → 05 Test Readiness → 06 Cutover/Rollback → 07 Handover`다.

## 의존성
- 02는 01 승인 후 시작한다.
- 03은 02 승인 후 시작한다.
- 04는 03의 Critical Unknown이 해소된 뒤 시작한다.
- 05는 요구/설계/Delivery 기준선이 존재해야 READY 판정이 가능하다.
- 06은 05가 READY이거나 사람이 명시적으로 잔여위험을 수용한 경우에만 계획 확정 단계로 간다.
- 07은 오픈 후 검증 Evidence와 운영 Runbook이 있어야 완료 가능하다.

## 재작업 Loop
Quality Gate 실패 시 원인을 `REQUIREMENT`, `ARCHITECTURE`, `DELIVERY`, `TEST`, `CUTOVER`로 분류하고 해당 단계부터 재실행한다. 동일 Gate 자동 반복은 최대 3회다. 이후 사람에게 Escalation한다.

`risk-manager`는 모든 단계에 병렬 호출할 수 있으나 Risk Acceptance는 하지 않는다.
