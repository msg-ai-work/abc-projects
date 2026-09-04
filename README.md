# Enterprise Messaging Projects AI Harness

`abc-projects`는 AX채널개발팀 기업메시징의 **Project Domain AI Harness**이며, SALL Forge의 실행 패턴을 기업메시징 SI/Migration/PoC에 맞춘 **ABC Project Forge**를 포함합니다.

## 역할

기업메시징 고객 구축, Migration, PoC, 내부 프로젝트의 실행 지식을 Domain Skill로 관리합니다.

## Common Harness

공통 Agent / Workflow / Rule / Guardrail은 `msg-ai-work/abc`를 SSOT로 사용합니다.
이 저장소는 공통 Harness를 복사해서 독립 관리하지 않습니다.

## 주요 영역

- 고객 구축 / SI
- Migration
- 요구사항 / 설계
- 시스템 연계
- 통합 테스트
- Cutover / Rollback
- 운영 이관
- PoC / 내부 프로젝트

## ABC Project Forge

```text
Project/Jira 요청
   ↓
Preflight
   ↓
project-orchestrator
   ↓
01 Intake → 02 Requirement → 03 Architecture/Integration
   ↓
04 Delivery/Migration → 05 Test Readiness
   ↓
06 Cutover/Rollback → 07 Handover
   ↓
Project Report

Quality Gate FAIL → 원인 Agent 재실행(최대 3회)
Human Gate → Scope/Architecture/Risk/Go-NoGo/Production/Rollback/운영인수
```

## Quick Start

1. 공통 Harness를 `.ai-harness/common`에 bootstrap 합니다.
2. `project-config.md`를 프로젝트에 맞게 수정합니다.
3. Kiro에서 `project-orchestrator` Agent를 선택합니다.
4. `/project-delivery <PROJECT-ID>`를 실행합니다.
5. 단계별 산출물은 `docs/projects/<PROJECT-ID>/`를 SSOT로 사용합니다.
6. PR 준비는 `/project-pr`, Merge 후 정리는 `/worktree-cleanup`을 사용합니다.

## 구성

- `.kiro/agents/`: Orchestrator + 7 Stage Agent + Risk/Review Agent
- `.kiro/steering/`: Chain, Quality/Human Gate, Evidence, 수동 명령
- `.kiro/hooks/`: Kiro v1 Preflight/Quality/Risk Hook
- `skills/`: 프로젝트 Domain Skill v1.0
- `workflows/`: Project Delivery, Worktree/PR 실행 흐름
- `templates/`: 단계별 산출물 계약
- `scripts/`: Preflight, Quality Gate, Worktree 관리
- `docs/`: Forge 설계/비교/Roadmap

## 역할 체계

| 역할 | 책임 |
|---|---|
| **리더** | Common Harness 방향, 공통 Rule/Guardrail, 운영 기준 및 최종 의사결정 관리 |
| **담당자** | Project Domain Skill, Knowledge, Runbook 작성·개선·최신화 |
| **Reviewer** | 변경 내용의 기술 적합성, 품질, 보안, 운영 영향 및 재사용성 검토 |

## 운영 원칙

> 리더는 AI가 일하는 방법을 관리하고, 담당자는 AI가 알아야 할 업무 지식을 관리하며, Reviewer는 변경의 품질과 안전성을 검증합니다.

- AI executes, humans decide.
- Skill 변경은 **담당자 작성 → Branch → Pull Request → Reviewer Review → main Merge** 순서로 관리합니다.
- 공통 정책 또는 고위험 변경은 필요 시 리더의 최종 판단을 거칩니다.
- Production credential/Secret/개인정보 원문은 Repository에 저장하지 않습니다.
- `.kiro/settings/mcp.json`은 로컬 전용이며 Git에는 `.example`만 저장합니다.

## 상세 문서

- `docs/ABC-PROJECT-FORGE.md`
- `docs/AGENT-DESIGN.md`
- `docs/SALL-FORGE-COMPARISON.md`
- `docs/ROADMAP.md`
