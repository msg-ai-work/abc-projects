---
name: project-intake-scope
description: 기업메시징 구축/SI/Migration/PoC 시작 시 목적, 범위, 이해관계자, 제약, 성공기준을 실행 가능한 프로젝트 계약으로 구조화한다.
metadata:
  responsible-role: 담당자
  reviewer-role: Reviewer
  version: "1.0"
---

# Project Intake / Scope

프로젝트 착수 단계에서 모호한 요청을 바로 설계나 구현으로 넘기지 않고, 이후 Skill들이 사용할 수 있는 프로젝트 범위 계약을 만든다.

## 사용할 때

- 신규 고객 구축, SI, Migration, PoC를 시작할 때
- 요청 범위나 책임 경계가 불명확할 때
- 일정/보안/기술 제약이 여러 조직에 걸쳐 있을 때
- 프로젝트 성공조건과 완료조건을 합의해야 할 때

## 입력 계약

가능한 범위에서 다음 근거를 먼저 읽는다.

- 고객/내부 요청 원문과 관련 문서
- 계약/제안/RFP/회의 결정사항
- 기존 시스템 및 서비스 범위
- 일정, 예산, 보안, 규제, 운영 제약

근거가 없는 정보는 사실처럼 만들지 않고 `Assumption` 또는 `Open Decision`으로 표시한다.

## 실행 절차

1. 해결하려는 비즈니스/운영 문제를 한 문장으로 정의한다.
2. 기대 효과와 사용자/고객 가치를 분리해 적는다.
3. `In Scope`와 `Out of Scope`를 명확히 분리한다.
4. 고객/당사/외부 시스템/협력사 등 이해관계자와 책임을 식별한다.
5. 일정, 예산, 보안, 개인정보, 기술, 운영 제약을 정리한다.
6. 기존 시스템과 재사용 가능한 기능을 확인해 불필요한 신규 범위를 줄인다.
7. 성공지표를 측정 가능한 값으로 정의하고 프로젝트 완료조건을 연결한다.
8. 미확정 항목을 `Assumption`, `Open Question`, `Decision Required`로 구분한다.
9. 범위 변경 가능성이 높은 항목과 외부 의존성을 초기 Risk로 등록한다.

## 중단 조건

다음 중 하나라도 핵심 범위에 영향을 주면 확정된 Scope로 간주하지 않는다.

- 프로젝트 목표가 한 문장으로 설명되지 않음
- In/Out Scope 경계가 충돌함
- 핵심 이해관계자 또는 책임 주체가 없음
- 성공기준이 측정 불가능함
- 보안/개인정보/계약상 제약이 미확정임

## 출력 계약

반드시 다음 항목을 구조화해 제공한다.

- Project Goal
- Business / Operation Problem
- In Scope / Out of Scope
- Stakeholder / Responsibility
- Constraint
- Dependency
- Success Criteria / Done Criteria
- Assumption
- Open Question
- Decision Required
- Initial Risk

## Human Gate

AI는 프로젝트 범위를 승인하지 않는다. 범위, 성공기준, 책임 경계가 확정되면 사람이 승인한 뒤 다음 단계로 진행한다.

## 다음 Skill

- 상세 요구 구체화: `requirement-analysis`
- 초기 위험 추적: `risk-issue-management`

## Self Check

완료 전 확인한다.

- 범위 밖 항목이 명시되어 있는가?
- 성공기준이 실제로 측정 가능한가?
- 외부 의존성과 책임 주체가 연결되어 있는가?
- 추정과 사실이 섞여 있지 않은가?
- 이후 요구사항 분석이 이 문서만으로 시작 가능한가?
