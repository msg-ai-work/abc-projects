# ABC Project Forge - Project Config

프로젝트별로 이 파일만 복사/수정하여 동일한 Project Forge를 재사용한다. Secret, 토큰, 개인정보 원문은 저장하지 않는다.

```yaml
project:
  id: SAMPLE-MSG-2026
  name: 기업메시징 구축 프로젝트
  type: si            # si | migration | poc | internal
  owner: <project-owner>

customer:
  name: <customer-or-internal>
  stakeholders: []

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
  project_key: <KEY>

document:
  provider: confluence
  space: <SPACE>

release:
  base_branch: develop
  worktree_root: ../abc-projects-worktrees
  production_human_gate: true

quality:
  unresolved_critical_risk: 0
  unresolved_high_risk: 0
  critical_defect: 0
  requirement_traceability_required: true
  rollback_plan_required: true
  evidence_required: true
```

## 변경 규칙

- 프로젝트마다 `project.id`, 담당자, Repository, 연계, Jira/Confluence, 브랜치 기준을 수정한다.
- 인증정보는 `.kiro/settings/mcp.json` 또는 사용자 전역 설정에서만 관리하고 Git에 커밋하지 않는다.
- 운영 승인자, 실제 Production credential, 고객 개인정보는 이 파일에 기록하지 않는다.
