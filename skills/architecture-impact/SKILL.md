---
name: architecture-impact
description: 프로젝트 변경이 기업메시징 아키텍처, 연계, 데이터, 보안, 성능, 운영, 장애전파와 원복 가능성에 미치는 영향을 체계적으로 분석한다.
metadata:
  responsible-role: 담당자
  reviewer-role: Reviewer
  version: "1.0"
---

# Architecture Impact

요구사항을 바로 구현하지 않고 AS-IS와 TO-BE 차이를 기반으로 변경의 Blast Radius와 기술적 의사결정을 식별한다.

## 사용할 때

- 신규 기능/연계/데이터 구조 변경 전
- 시스템 교체 또는 Migration 전
- 공통 컴포넌트, Queue, DB, Cache, Network 변경 전
- 장애 전파나 운영 영향이 우려될 때

## 입력 계약

- 승인된 요구사항과 Acceptance Criteria
- AS-IS 아키텍처/인터페이스/배포 구조
- 관련 코드 또는 설정의 근거
- 성능, 보안, DR, 운영 기준

근거를 찾을 수 없는 시스템 동작은 추정으로 표시하고 검증 항목으로 남긴다.

## 실행 절차

1. AS-IS 요청/데이터/메시지 흐름을 식별한다.
2. TO-BE에서 변경되는 Component, Interface, Data, Config를 표시한다.
3. 직접 영향과 간접 영향을 구분해 Blast Radius를 작성한다.
4. 다음 영역을 빠짐없이 검토한다.
   - Application / Component
   - API / Event / Batch / File
   - DB / Cache / Queue
   - Network / Security / Privacy
   - Capacity / Performance
   - Monitoring / Logging / Operation
   - DR / Backup / Recovery
5. 호환성, 데이터 정합성, 동시성, Idempotency, 순서보장, Timeout/Retry 영향을 확인한다.
6. 장애 시 Failure Propagation과 격리 지점을 분석한다.
7. 피크 트래픽과 자원 병목 가능성을 확인한다.
8. 배포/전환/원복 가능성과 변경 후 데이터 처리 영향을 평가한다.
9. 기존 기능 또는 표준 기능을 재사용할 수 있는지 확인해 불필요한 신규 구조를 줄인다.
10. 중요한 기술 선택은 `ADR Candidate`로 분리하고 선택지/Trade-off를 기록한다.

## 중단 조건

다음 중 하나라도 핵심 설계에 영향을 주면 구현 준비 완료로 판단하지 않는다.

- AS-IS 또는 TO-BE 흐름이 확인되지 않음
- 핵심 외부 연계의 계약/책임이 불명확함
- 데이터 정합성 또는 Rollback 가능성을 설명할 수 없음
- 보안/개인정보 영향이 미평가 상태임
- Capacity 기준 없이 대용량 경로를 변경함

## 출력 계약

- AS-IS / TO-BE Flow
- Change Point
- Impact Matrix
- Dependency / Blast Radius
- Failure Scenario / Failure Isolation
- Capacity / Performance Impact
- Security / Privacy Impact
- Monitoring / Operation Impact
- Rollback Impact
- ADR Candidate / Recommendation
- Open Question / Risk

## Human Gate

AI는 아키텍처 선택, 보안 예외, 운영 위험 수용을 최종 승인하지 않는다. 중요한 ADR과 Production 영향은 사람이 결정한다.

## 다음 Skill

- 연계 상세설계: `integration-design`
- 데이터/시스템 전환: `migration-plan`
- 시험 준비: `test-readiness`
- Risk 관리: `risk-issue-management`

## Self Check

- 변경점에서 한 단계 밖의 간접 영향까지 확인했는가?
- 실패 시 어디까지 장애가 전파되는지 설명 가능한가?
- 성능/보안/운영/DR이 모두 검토되었는가?
- Rollback 불가능한 변경을 명시했는가?
- ADR이 필요한 결정을 숨기지 않았는가?
