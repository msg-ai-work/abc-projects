---
name: requirement-analysis
description: 고객/내부 요구를 기능·비기능·운영·보안 요구로 구조화하고 추적 가능하며 테스트 가능한 Acceptance Criteria로 만든다.
metadata:
  owner: projects
  version: "1.0"
---

# Requirement Analysis

승인된 프로젝트 Scope를 기반으로 모호한 요구를 설계·개발·테스트가 가능한 계약으로 변환한다.

## 사용할 때

- 요구사항 정의/정제/검토가 필요할 때
- 고객 요청이 자연어 수준에 머물러 있을 때
- 기능과 운영/보안 요구가 섞여 있을 때
- UAT 또는 테스트 기준을 만들기 전에

## 입력 계약

- 승인된 `project-intake-scope` 결과 또는 동등한 Scope 문서
- 고객/내부 요구 원문과 정책 근거
- 기존 기능/화면/API/운영 절차
- 관련 규제, 개인정보, 보안 기준

요구의 근거가 불명확하면 임의 해석하지 않고 질문 또는 Decision 항목으로 남긴다.

## 실행 절차

1. 요구의 목적, 사용자/시스템 주체, 업무 시나리오를 확인한다.
2. 요구를 `Functional`, `Non-Functional`, `Operation`, `Security/Privacy`, `Data/Integration`으로 분류한다.
3. 모호한 표현을 `입력 → 조건 → 행동 → 결과`로 구체화한다.
4. 정상 흐름뿐 아니라 오류, 예외, 재시도, 중복, Timeout, 권한 실패를 확인한다.
5. 기존 기능과 충돌/중복/재사용 가능성을 확인한다.
6. 데이터 생성·변경·보존·삭제 및 개인정보 처리 요구를 확인한다.
7. 연계가 있으면 성공 응답의 의미, Idempotency, 순서, Retry, Error 처리 요구를 정의한다.
8. 성능 요구는 TPS, Latency, 동시사용자, 배치량 등 측정 가능한 값으로 표현한다.
9. 각 요구사항에 식별자를 부여하고 Acceptance Criteria를 Given/When/Then 또는 동등한 검증 가능한 형태로 정의한다.
10. 요구사항과 Acceptance Criteria 사이 Traceability를 확인한다.

## 중단 조건

다음 항목은 승인된 요구로 간주하지 않는다.

- 주체/입력/조건/결과 중 핵심 요소가 없음
- 성공 여부를 테스트로 판정할 수 없음
- 기존 정책과 충돌하지만 의사결정이 없음
- 개인정보/보안 처리가 불명확함
- 미결정 요구를 사실처럼 확정해야만 진행 가능함

## 출력 계약

- Requirement ID / Category / Source
- Business Rule
- Preconditions / Main Flow / Exception Flow
- Data / Integration Requirement
- Non-Functional Requirement
- Security / Privacy Requirement
- Acceptance Criteria
- Traceability Matrix
- Assumption / Open Question / Decision Required

## Human Gate

AI는 요구사항을 승인하거나 고객 의사결정을 대신하지 않는다. 핵심 요구와 Acceptance Criteria는 사람이 승인해야 한다.

## 다음 Skill

- 시스템 영향 분석: `architecture-impact`
- 외부 연계 상세화: `integration-design`
- Risk/Issue 등록: `risk-issue-management`

## Self Check

- 모든 요구에 근거 출처가 있는가?
- 기능 외 운영/보안/비기능 요구가 빠지지 않았는가?
- 각 Acceptance Criteria를 실제 테스트할 수 있는가?
- 모호한 표현이 남아 있지 않은가?
- 미확정 요구가 승인된 요구와 섞이지 않았는가?
