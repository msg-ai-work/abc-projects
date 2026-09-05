# ABC Project Forge - Project Config

이 파일은 현재 **SAMPLE-MSG-2026 Phase 1 Runtime Test** 기준 설정입니다. Secret, 토큰, 개인정보 원문은 저장하지 않습니다. 실제 고객 프로젝트에 적용할 때는 이 파일을 복사해 프로젝트별 값으로 변경합니다.

```yaml
project:
  id: SAMPLE-MSG-2026
  name: 기업메시징 AI Harness Runtime Test
  type: internal      # si | migration | poc | internal
  owner: choiss7

customer:
  name: internal-runtime-test
  stakeholders:
    - leader
    - project-assignee
    - reviewer

repositories:
  common: msg-ai-work/abc
  project: msg-ai-work/abc-projects
  engine: msg-ai-work/abc-engine
  web: msg-ai-work/abc-web
  tech_support: msg-ai-work/abc-tech-support

integrations:
  - sms-mms-gw
  - rcs
  - customer-api

environments:
  dev: dev
  stage: stage
  prod: prod

work_item:
  provider: jira
  project_key: SAMPLE

document:
  provider: confluence
  space: SAMPLE

release:
  base_branch: main
  worktree_root: ../abc-projects-worktrees
  production_human_gate: true

runtime_test:
  enabled: true
  external_write_enabled: false
  production_execution_enabled: false
  real_customer_data_enabled: false

quality:
  unresolved_critical_risk: 0
  unresolved_high_risk: 0
  critical_defect: 0
  requirement_traceability_required: true
  rollback_plan_required: true
  evidence_required: true
```

## Runtime Test 규칙

- `SAMPLE-MSG-2026`은 내부 Harness 검증용이며 실제 고객 프로젝트가 아닙니다.
- Jira/Confluence 값 `SAMPLE`은 식별용 테스트 값이며 외부 시스템 쓰기를 수행하지 않습니다.
- AI는 Scope/Requirement/Architecture 승인, Risk Acceptance, Go/No-Go, Production, Rollback, 운영 인수를 대신 승인하지 않습니다.
- 인증정보는 `.kiro/settings/mcp.json` 또는 사용자 전역 설정에서만 관리하고 Git에 커밋하지 않습니다.
- 실제 Production credential, 고객 개인정보 및 민감 로그는 이 파일이나 Runtime 산출물에 기록하지 않습니다.
