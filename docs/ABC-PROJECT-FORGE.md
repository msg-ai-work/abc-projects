# ABC Project Forge

## 정의
SALL Forge의 `요청→Agent Chain→QA Loop→Worktree→PR` 패턴을 기업메시징 SI/Migration 프로젝트에 맞게 확장한 Project Execution Harness다.

## 역할 분리
- `abc`: 공통 Governance, Rule, Security, 공통 개발 Workflow SSOT
- `abc-projects`: 프로젝트 Domain Agent/Skill/Workflow/Template
- `project-config.md`: 프로젝트별 차이만 선언
- `project-orchestrator`: 단계 판정과 Sub Agent DAG/Loop 관리
- `skills/*`: 업무 방법
- `docs/projects/<id>`: 실제 프로젝트 산출물 SSOT

## 사용자 경험
- `/project-delivery <id>`: 전체 체인 시작/재개
- `/project-pr <id>`: Quality Gate 후 PR 준비
- `/worktree-cleanup <id>`: Merge 후 정리

## 핵심 원칙
1. Agent=역할, Skill=업무매뉴얼, Workflow=프로세스, Orchestrator=PM.
2. 다음 단계는 문서 존재가 아니라 Gate 충족으로 넘어간다.
3. 실패는 관련 이전 Agent로 되돌린다.
4. AI는 Production과 승인 결정을 대신하지 않는다.
5. 여러 프로젝트는 Worktree로 격리한다.
