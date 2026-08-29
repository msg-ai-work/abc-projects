---
name: migration-plan
summary: 시스템/데이터 Migration의 대상, 순서, 검증, 원복 기준을 계획한다.
version: "0.1"
---
# Migration Plan
## 절차
1. Migration 대상과 제외 대상을 확정한다.
2. 데이터 매핑/변환/정합성 기준을 정의한다.
3. 사전 Migration과 본 Migration을 분리한다.
4. 소요시간과 서비스 영향 시간을 추정한다.
5. Before/After 검증 항목을 정의한다.
6. 실패 조건과 Rollback 방식을 연결한다.
## Guardrail
운영 데이터 변경은 승인된 Runbook과 담당자 승인 없이 수행하지 않는다.
