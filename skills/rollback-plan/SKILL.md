---
name: rollback-plan
description: 오픈/전환 실패 시 안전한 원복 조건, 의사결정 시점, Application/Config/Data 복구 순서와 정합성 검증을 사전에 정의한다.
metadata:
  responsible-role: 담당자
  reviewer-role: Reviewer
  version: "1.0"
---

# Rollback Plan

원복을 배포 당일의 즉흥 판단이 아니라, 실행 전에 검증된 실패 대응 계약으로 만든다.

## 사용할 때

- Production 변경/Cutover/Migration 전
- 데이터 변경이 포함된 배포 전
- 장애 영향이 크거나 다수 시스템이 연결된 변경 전
- 원복 가능 여부와 최대 판단시점을 정해야 할 때

## 입력 계약

- 승인된 Cutover/Migration 계획
- 변경 대상 Application/Config/DB/Data 목록
- Backup/Snapshot/Artifact 보관 계획
- 정상성 검증 기준
- 의사결정/승인권자와 서비스 영향시간

## 실행 절차

1. Rollback Trigger를 오류율, 핵심 기능 실패, 데이터 불일치, 성능 저하 등 수치/현상 기준으로 정의한다.
2. Trigger별 즉시 중단/관찰/부분 원복/전체 원복 판단을 구분한다.
3. 되돌릴 범위를 Application, Config, Routing, Schema, Data, Integration으로 나눈다.
4. 원복 순서와 시스템 간 의존성을 정리한다.
5. 변경 이후 새로 생성/변경된 데이터의 보존, 보정, 재처리, 폐기 기준을 정의한다.
6. DB Schema/Data 변경이 역변환 가능한지 확인하고 불가능하면 별도 복구 전략을 명시한다.
7. Backup/Snapshot/이전 Artifact의 존재와 복구 가능성을 사전에 검증한다.
8. Rollback 예상시간과 서비스 영향시간을 계산 또는 근거와 함께 추정한다.
9. 최대 의사결정 시점(Point of No Return 포함)을 정의한다.
10. 원복 후 서비스, 데이터, 발송/처리, 외부 연계, 모니터링 정상성 검증을 정의한다.
11. 원복 자체 실패 시 Escalation/DR/수동 복구 경로를 정의한다.
12. 리허설 가능한 절차는 비운영 환경 또는 안전한 방식으로 사전 검증한다.

## 중단 조건

다음 중 하나라도 핵심 변경에 해당하면 오픈 준비 완료로 판단하지 않는다.

- Rollback Trigger가 주관적 표현뿐임
- 이전 Artifact/Backup 복구 가능성 미확인
- 변경 후 데이터 처리 기준 없음
- 데이터/Schema 변경이 비가역적인데 대안 없음
- 최대 의사결정 시점과 승인권자 미정
- 원복 후 검증 방법 없음

## 출력 계약

- Rollback Trigger / Severity
- Decision Matrix
- Rollback Scope
- Step / Dependency / 담당자
- Data Handling Rule
- Backup / Artifact Verification
- Expected Duration / Service Impact
- Point of No Return
- Post-rollback Validation
- Rollback Failure / Escalation
- Rehearsal Evidence
- Open Decision / Risk

## Human Gate

Rollback 실행 여부, Production 변경, 데이터 복구 방식과 위험 수용은 사람이 결정한다. AI는 Production 원복 명령을 단독 실행하지 않는다.

## 다음 Skill

- 오픈 실행 연결: `cutover-plan`
- Migration 연계: `migration-plan`
- 원복 후 이슈 추적: `risk-issue-management`

## Self Check

- 원복 조건이 누구나 동일하게 판정 가능한가?
- Application 원복과 Data 원복을 구분했는가?
- 변경 후 생성된 데이터를 어떻게 처리할지 명확한가?
- 원복 가능한 마지막 시점이 정의됐는가?
- 원복 후 정상성을 End-to-End로 확인할 수 있는가?
