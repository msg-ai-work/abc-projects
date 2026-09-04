# ABC Project Forge Roadmap

| Phase | GitHub Issue | 목표 | 완료 기준 |
|---|---|---|---|
| 1 | #3 | Core Orchestration | project-config 하나로 01→05 체인, Human Gate 차단 검증 |
| 2 | #4 | Quality Gate / Rework Loop | 결함 유형을 올바른 Agent로 복귀, 3회 후 Escalation |
| 3 | #5 | Worktree / PR | 2개 이상 프로젝트 병렬 격리, Gate 후 PR |
| 4 | #6 | Jira / Confluence | Jira Key 기반 Context/Evidence/Traceability |
| 5 | #7 | Evals / Metrics | Gate 품질·Cycle Time·Rework를 정량 비교 |

## Phase 1 - Core Orchestration (#3)
- `project-config.md`
- project-orchestrator + 7 Sub Agents
- 기본 Template/Workflow
- 샘플 프로젝트로 Human Gate와 단계 의존성 검증

## Phase 2 - Quality / Harness Loop (#4)
- 단계별 Quality Gate 자동화
- risk-manager/project-reviewer
- 최대 3회 Rework Loop
- 정상/실패 Evals

## Phase 3 - Worktree / PR Automation (#5)
- Worktree 생성/정리
- GitHub MCP
- PR Body 자동화
- 메인 작업공간 무오염 검증

## Phase 4 - Jira / Confluence Integration (#6)
- Jira Intake/Defect 조회
- Confluence 설계/결정 Evidence
- 외부 쓰기 Human Gate

## Phase 5 - Metrics / Continuous Improvement (#7)
- First Pass Yield / Gate Pass Rate
- Rework Loop 원인/횟수
- Requirement→TC Traceability
- AI 수행시간 대비 사람 검토시간
- Skill 변경 전/후 Evals 비교

## 권장 순서
`#3 → #4 → #5 → #6 → #7`. Phase 1/2가 안정화되기 전 외부 MCP 자동화를 과도하게 넓히지 않는다.
