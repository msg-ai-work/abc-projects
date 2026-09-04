---
name: test-readiness
description: 프로젝트가 통합/UAT/성능/보안 시험을 시작할 준비가 되었는지 요구사항 추적성, 환경, 데이터, 연계, Defect, Threshold, Evidence 기준으로 판정한다.
metadata:
  responsible-role: 담당자
  reviewer-role: Reviewer
  version: "1.0"
---

# Test Readiness

테스트를 시작한 뒤 준비 부족을 발견하지 않도록, 시험 시작 전에 Blocking 조건을 찾아 제거한다.

## 사용할 때

- 통합테스트/UAT/성능/보안 시험 시작 전
- Test Cycle 전환 시
- 외부 연계 시스템과 공동 시험할 때
- 오픈 전 최종 검증 범위를 확인할 때

## 입력 계약

- 승인된 요구사항과 Acceptance Criteria
- Architecture / Integration 설계
- 구현 Version / Build 정보
- 테스트 환경과 기준 데이터
- Test Case / Defect Workflow / 담당자
- 성능·보안·개인정보 기준

## 실행 절차

1. 요구사항과 Test Case 간 Traceability를 확인한다.
2. 테스트 대상 Version/Commit/Config가 고정되어 있는지 확인한다.
3. 환경, 계정, 권한, Network, 인증서, 외부 연계 준비상태를 점검한다.
4. 정상/예외/경계/재처리 시나리오용 기준 데이터를 확인한다.
5. 외부 시스템별 시험 가능 시간, 담당자, 장애 연락체계를 확인한다.
6. Defect 등록 → 우선순위 → 수정 → 재검증 → 종료 Workflow를 확인한다.
7. 성능 시험은 TPS/Latency/Error Rate/자원 Threshold와 부하 모델을 확인한다.
8. 보안/개인정보 시험 범위와 Evidence 기준을 확인한다.
9. 테스트 결과/로그/스크린샷/Trace 등 Evidence 저장 위치와 Naming Rule을 정한다.
10. Blocking 항목을 별도 목록으로 만들고 담당자/Due Date를 부여한다.
11. Ready/Conditionally Ready/Not Ready로 판정하고 근거를 기록한다.

## Readiness Checklist

- [ ] Requirement ↔ TC Traceability
- [ ] Test Version / Config 고정
- [ ] Test Environment / Account / Network 준비
- [ ] 기준 데이터 준비
- [ ] 연계 시스템/담당자 준비
- [ ] Defect Workflow 확정
- [ ] 성능 Threshold 정의
- [ ] 보안/개인정보 범위 확정
- [ ] Evidence 저장 위치 확정
- [ ] Blocking Issue 담당자 / Due Date 지정

## 판정 기준

- `Ready`: Blocking 조건 없음
- `Conditionally Ready`: 우회 가능하고 승인된 제한사항만 존재
- `Not Ready`: 핵심 TC 수행을 막거나 결과 신뢰성을 훼손하는 Blocking 조건 존재

Blocking 조건이 남아 있으면 임의로 `Ready`로 판정하지 않는다.

## 출력 계약

- Test Scope / Cycle
- Version / Environment Baseline
- Traceability Status
- Data / Integration Readiness
- Defect Workflow
- Performance / Security Criteria
- Evidence Rule
- Blocking List
- Readiness Decision & Rationale
- Risk / Open Decision

## Human Gate

AI는 테스트 완료, 품질 승인, 미해결 Defect 위험 수용을 대신하지 않는다. 조건부 진행과 품질 위험 수용은 책임자가 승인한다.

## 다음 Skill

- 시험 중 발생 이슈: `risk-issue-management`
- 오픈 준비: `cutover-plan`
- 설계 결함 발견 시: `architecture-impact` 또는 `integration-design`

## Self Check

- 테스트를 수행할 수 있는가가 아니라 결과를 신뢰할 수 있는가까지 확인했는가?
- 외부 연계 의존성이 모두 준비되었는가?
- 성능/보안 시험의 합격 기준이 수치 또는 명확한 판정 기준으로 정의됐는가?
- Blocking Issue에 담당자와 Due Date가 있는가?
- Evidence만으로 제3자가 결과를 재검증할 수 있는가?
