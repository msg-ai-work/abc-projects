---
name: migration-plan
description: 시스템/데이터 Migration의 대상, 순서, 정합성, 소요시간, 검증, 실패조건과 Rollback 연결을 실행 가능한 전환 계획으로 만든다.
metadata:
  responsible-role: 담당자
  reviewer-role: Reviewer
  version: "1.0"
---

# Migration Plan

Migration을 단순 작업 순서가 아니라 데이터 정합성, 서비스 영향, 검증과 원복까지 연결된 통제된 실행계획으로 만든다.

## 사용할 때

- 데이터/시스템/플랫폼 전환이 필요한 프로젝트
- 사전 적재와 본 전환을 분리해야 할 때
- 운영 데이터 변환/이관이 필요한 경우
- Migration 실패 시 Rollback 기준이 필요한 경우

## 입력 계약

- 승인된 요구사항과 Architecture Impact
- Migration 대상/제외 대상 목록
- Source/Target Schema와 데이터량
- 정합성 기준과 보존 정책
- 서비스 중단 허용시간 및 Cutover 제약

## 실행 절차

1. Migration 대상, 제외 대상, Source/Target과 담당자를 확정한다.
2. 데이터 매핑, 변환, Default/Null, Code 변환, 중복 제거 규칙을 정의한다.
3. 전체 데이터량, 변경량, 처리속도와 예상 소요시간을 계산 또는 근거와 함께 추정한다.
4. `Pre-Migration`, `Delta`, `Final Migration` 등 단계로 분리할 수 있는지 검토한다.
5. 각 단계의 선행조건, 실행 순서, 병렬 가능 여부와 의존성을 정리한다.
6. Before/After Count, Key Sample, Aggregate, 업무 정합성 등 검증 기준을 정의한다.
7. Migration 중 신규/변경 데이터 처리와 동시성 문제를 정의한다.
8. 실패 유형별 Stop/Retry/Resume/Rollback 조건을 정의한다.
9. 변경 후 생성된 데이터가 Rollback 시 어떻게 처리되는지 명확히 한다.
10. 실행 Evidence, 로그, 결과 저장 위치와 담당자를 정의한다.
11. Dry-run 또는 비운영 데이터 기반 리허설 계획을 수립한다.

## 중단 조건

다음이 해결되지 않으면 운영 Migration 실행 준비 완료로 판단하지 않는다.

- Source/Target 데이터 매핑 미확정
- 정합성 판정 기준 없음
- 예상 소요시간이 서비스 영향 시간 내인지 검증 안 됨
- 신규/변경 데이터의 동시 처리 방식 미정
- 실패 시 재시작/원복 방식 미정
- 운영 데이터 변경 승인/Runbook 없음

## 출력 계약

- Migration Scope / Inventory
- Source → Target Mapping
- Transformation Rule
- Volume / Throughput / Duration Estimate
- Phase / Sequence / Dependency
- Before / After Validation
- Concurrent Change Handling
- Failure / Resume / Retry Strategy
- Rollback Linkage
- Evidence / 담당자
- Rehearsal Plan
- Risk / Open Decision

## Guardrail / Human Gate

운영 데이터 변경은 승인된 Runbook과 담당자 승인 없이 수행하지 않는다. AI는 Production 자격증명을 사용하거나 운영 Migration을 단독 실행하지 않는다.

## 다음 Skill

- 오픈 실행계획: `cutover-plan`
- 원복 상세화: `rollback-plan`
- 시험 준비: `test-readiness`
- 위험 추적: `risk-issue-management`

## Self Check

- 데이터량과 소요시간에 근거가 있는가?
- Before/After 검증만으로 실제 업무 정합성을 판정할 수 있는가?
- Migration 도중 발생하는 변경 데이터를 놓치지 않는가?
- 중간 실패 후 Resume 가능 여부가 명확한가?
- Rollback 시 변경 후 데이터 처리까지 정의했는가?
