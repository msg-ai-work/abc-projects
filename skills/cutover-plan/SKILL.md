---
name: cutover-plan
description: 프로젝트 오픈 시각부터 안정화까지 사전작업, 실행순서, Evidence, Go/No-Go, 검증, Hypercare와 Escalation을 포함한 Cutover Runbook을 만든다.
metadata:
  responsible-role: 담당자
  reviewer-role: Reviewer
  version: "1.0"
---

# Cutover Plan

오픈을 단순 배포가 아니라 사람, 시스템, 데이터, 검증, 의사결정이 시간순으로 연결된 실행 가능한 Runbook으로 만든다.

## 사용할 때

- 신규 서비스/기능/고객 구축 오픈 전
- Migration과 배포가 함께 수행될 때
- 병행운영, 점진전환, Hypercare가 필요한 경우
- Go/No-Go 기준과 상황실 체계가 필요할 때

## 입력 계약

- 승인된 요구사항/설계와 테스트 결과
- `migration-plan` 및 `rollback-plan` 초안
- 배포 대상 Version/Artifact/Config
- 오픈 일정, 작업자, 승인권자, 연락체계
- 서비스/데이터/발송/빌링/모니터링 검증 기준

## 실행 절차

1. Cutover 목표, 시작/종료 시각, 영향 서비스와 고객 범위를 정의한다.
2. 사전 작업, Change Freeze, Backup/Snapshot, 기준 데이터 Capture를 정의한다.
3. 작업을 시간순으로 나누고 각 단계의 담당자, 예상시간, 선행조건을 지정한다.
4. Application, Config, DB, Migration, Routing, External Integration 변경을 명확히 구분한다.
5. 각 단계에 완료조건과 Evidence를 정의한다.
6. 중요한 전환 지점마다 Go/No-Go Checkpoint를 배치한다.
7. Go/No-Go 기준은 오류율, 핵심 기능, 데이터 정합성, 처리량 등 가능한 한 측정 가능하게 정의한다.
8. 오픈 직후 서비스, 메시지 발송, 데이터, 빌링/과금, 모니터링, 주요 업무 시나리오를 검증한다.
9. 병행운영/Canary/점진전환이 가능하면 Big Bang보다 우선 검토한다.
10. Rollback Trigger와 최대 의사결정 시각을 `rollback-plan`과 연결한다.
11. Hypercare 기간, 관찰 지표, 상황실, Escalation 연락체계를 정의한다.
12. 정상화 종료조건과 운영 이관 시점을 정의한다.

## 중단 조건

다음 중 하나라도 없으면 Cutover Ready로 판단하지 않는다.

- 확정된 작업 Version/Artifact
- 각 단계 담당자와 완료 Evidence
- Go/No-Go 기준과 승인권자
- Rollback Trigger/절차
- 핵심 서비스/데이터 검증 방법
- 장애/비상 연락체계

## 출력 계약

- Cutover Scope / Timeline
- Pre-work / Freeze / Backup
- Step / 담당자 / ETA / Dependency
- Completion Evidence
- Go/No-Go Checkpoint & Criteria
- Post-open Validation
- Rollback Linkage
- Hypercare / Monitoring
- Escalation Matrix
- Stabilization Exit Criteria
- Open Decision / Risk

## Human Gate

Go/No-Go, Production 전환, Rollback 전환, 미해결 위험 수용은 반드시 사람이 승인한다. AI는 Production 배포나 운영 명령을 단독 실행하지 않는다.

## 다음 Skill

- 원복 상세: `rollback-plan`
- 오픈 후 운영 인수: `handover-readiness`
- 오픈 이슈 관리: `risk-issue-management`

## Self Check

- 작업 순서만 보고 제3자가 실제 오픈을 수행할 수 있는가?
- 각 단계의 완료 여부를 Evidence로 판정할 수 있는가?
- 언제 멈추고 언제 원복하는지가 수치/현상 기준으로 정의됐는가?
- 서비스 정상뿐 아니라 데이터/발송/빌링까지 검증하는가?
- Hypercare 종료 기준이 있는가?
