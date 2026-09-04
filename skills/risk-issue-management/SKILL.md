---
name: risk-issue-management
description: 프로젝트 Risk와 Issue를 사실, 영향, 확률, 우선순위, 조치, 담당자, Due Date, 의사결정 기준으로 구조화하고 종료까지 추적한다.
metadata:
  responsible-role: 담당자
  reviewer-role: Reviewer
  version: "1.0"
---

# Risk / Issue Management

Risk와 Issue를 단순 목록이 아니라 다음 행동과 의사결정이 분명한 관리 항목으로 만든다.

## 사용할 때

- 프로젝트 전 기간의 Risk/Issue 관리
- 일정/품질/범위/보안/운영 영향이 발생하거나 예상될 때
- 외부 의존성, 의사결정 지연, Defect가 프로젝트 목표에 영향을 줄 때
- Go/No-Go 또는 위험 수용 판단 자료가 필요할 때

## 구분

- `Risk`: 아직 발생하지 않았으나 발생 가능성이 있는 사건
- `Issue`: 이미 발생해 일정/품질/범위/비용/운영에 영향을 주는 사건
- `Decision`: 해결을 위해 책임자의 선택이 필요한 항목
- `Action`: Risk/Issue/Decision을 처리하기 위한 구체적 작업

## 입력 계약

- 사실 근거: 테스트 결과, 로그, 일정, 회의 결정, 시스템 상태 등
- 영향받는 Scope/마일스톤/요구사항
- 관련 담당자/의사결정자
- 기존 조치와 Due Date

사실과 추정을 반드시 분리한다. 근거가 없으면 `Assumption`으로 표시한다.

## 실행 절차

1. 제목을 결과 중심이 아니라 문제/위험이 드러나는 한 문장으로 작성한다.
2. `Fact`, `Assumption`, `Impact`를 분리한다.
3. Risk/Issue/Decision 중 유형을 구분한다.
4. 영향 영역을 Schedule, Scope, Quality, Security/Privacy, Cost, Operation, Customer로 표시한다.
5. Risk는 Probability와 Impact를 평가하고 예방/완화/Contingency를 정의한다.
6. Issue는 현재 영향, 임시조치, 근본조치, 복구/재검증 기준을 정의한다.
7. Severity/Priority를 근거와 함께 평가한다.
8. 각 Action에 단일 담당자와 Due Date를 지정한다.
9. 외부 의존성 또는 의사결정이 필요하면 의사결정 담당자와 필요 시점을 명시한다.
10. 오픈/Cutover에 영향을 주면 Go/No-Go 기준과 연결한다.
11. 상태를 `Open`, `Monitoring`, `Mitigated`, `Resolved`, `Accepted` 등으로 관리하고 상태 변경 근거를 남긴다.
12. 종료 시 단순 조치 완료가 아니라 영향 제거와 재발/잔여위험을 검증한다.

## 우선순위 원칙

- 고객 영향/데이터 손실/보안/대규모 장애 가능성은 최우선으로 본다.
- Due Date만 가까운 항목보다 프로젝트 Critical Path 영향이 큰 항목을 우선한다.
- 담당자 없는 Risk/Issue는 관리되고 있는 것으로 보지 않는다.
- `Accepted`는 조치 불필요가 아니라 사람이 잔여위험을 수용했다는 의미다.

## 출력 계약

- ID / Type / Title
- Fact / Assumption
- Impact Area / Severity / Priority
- Probability (Risk)
- Current Impact (Issue)
- Prevention / Mitigation / Contingency
- Temporary Fix / Root Action
- 담당자 / Due Date
- Decision Required / 의사결정 담당자
- Go/No-Go Impact
- Status / Evidence
- Residual Risk / Close Criteria

## Human Gate

AI는 위험 수용, 일정/범위 변경, 보안 예외, Go/No-Go를 승인하지 않는다. `Accepted` 상태는 반드시 권한 있는 사람이 결정한다.

## 연계 Skill

- Scope 영향: `project-intake-scope`
- 요구/설계 영향: `requirement-analysis`, `architecture-impact`, `integration-design`
- 시험 Blocking: `test-readiness`
- 오픈 위험: `cutover-plan`, `rollback-plan`
- 운영 이관 위험: `handover-readiness`

## Self Check

- 사실과 의견/추정이 구분되어 있는가?
- 모든 Open 항목에 담당자와 Due Date가 있는가?
- Risk에 예방과 Contingency가 모두 필요한지 검토했는가?
- Issue의 임시조치와 근본조치를 혼동하지 않았는가?
- 종료 기준과 잔여위험이 명확한가?
