# ABC Project Forge Agent Design

## 설계 원칙
`Agent = 역할`, `Skill = 업무 매뉴얼`, `Workflow = 수행 프로세스`, `Orchestrator = PM`으로 분리한다.

| Agent | 필수 입력 | 사용하는 Skill | 핵심 출력 | Quality Gate | Human Gate |
|---|---|---|---|---|---|
| project-orchestrator | project-config, 기존 산출물 | 전체 | 단계계획, Gate 상태, 다음 Action | 전체 Chain | 모든 승인 의사결정 |
| 01-project-intake | 요청/Jira/회의근거 | project-intake-scope | 01-PROJECT-INTAKE.md | Scope/Success Criteria | Scope 승인 |
| 02-requirement | Approved Intake | requirement-analysis | 02-REQUIREMENT.md | AC/Traceability/Open Decision | 요구 승인 |
| 03-architecture | Approved Requirement | architecture-impact, integration-design | Impact/Interface | Critical Unknown, Failure/Retry | Architecture 기준선 |
| 04-delivery-plan | Architecture/Integration | migration-plan, risk-issue-management | Delivery/Risk Register | Owner/Dependency/정합성 | 일정/범위 변경 |
| 05-test-readiness | 02~04 산출물 | test-readiness | READY/NOT READY | TC/환경/데이터/성능/보안 | 잔여위험 수용 |
| 06-cutover | READY 결과 | cutover-plan, rollback-plan | Cutover/Rollback | Monitoring/Trigger/Evidence | Go-NoGo/Production/Rollback |
| 07-handover | 오픈 검증/Runbook | handover-readiness | Handover/Project Report | 실제 운영 수행가능 | 운영 인수 |
| risk-manager | 전 단계 Fact | risk-issue-management | Risk/Issue/Decision/Action | Owner/Due/Residual Risk | Risk Acceptance |
| project-reviewer | 01~07 전체 | 전체 | 독립 리뷰/재작업 제안 | Cross-stage 일관성 | 승인 대신하지 않음 |

## Orchestrator 동작
1. 프로젝트 ID와 현재 Stage를 결정한다.
2. 선행 산출물 상태와 Human Gate를 확인한다.
3. 필요한 Agent만 sub-agent로 호출한다.
4. 독립 작업은 병렬, 승인 의존 작업은 순차 실행한다.
5. 결과를 Quality Gate로 판정한다.
6. FAIL 원인을 `REQUIREMENT/ARCHITECTURE/DELIVERY/TEST/CUTOVER`로 분류한다.
7. 해당 Agent로 최대 3회 재작업 후에도 실패하면 사람에게 Escalation한다.
8. 종료 시 `현재단계 / Gate / Open Risk / Decision / Next Human Action`을 요약한다.

## Context 경계
각 Sub Agent는 대화 전체를 상속하지 않고 자신의 입력 문서와 Skill을 중심으로 판단한다. 프로젝트 상태는 대화 기억보다 `docs/projects/<id>/` 산출물을 우선한다.

## 구현 Agent와의 경계
`abc-projects`의 04 Delivery Agent는 실제 Engine/Web/발송 Client 코드를 직접 소유하지 않는다. 코드 구현이 필요한 경우 `abc-engine`, `abc-web`, `abc-tech-support`의 Domain Harness로 작업을 위임하고 이 Repository에는 계획/검증/Evidence 링크를 남긴다.
