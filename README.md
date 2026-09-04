# Enterprise Messaging Projects AI Harness

`abc-projects`는 AX채널개발팀 기업메시징의 **Project Domain AI Harness** 저장소입니다.

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

## 역할 체계

| 역할 | 책임 |
|---|---|
| **리더** | Common Harness 방향, 공통 Rule/Guardrail, 운영 기준 및 최종 의사결정 관리 |
| **담당자** | Project Domain Skill, Knowledge, Runbook 작성·개선·최신화 |
| **Reviewer** | 변경 내용의 기술 적합성, 품질, 보안, 운영 영향 및 재사용성 검토 |

## 운영 원칙

> 리더는 AI가 일하는 방법을 관리하고, 담당자는 AI가 알아야 할 업무 지식을 관리하며, Reviewer는 변경의 품질과 안전성을 검증합니다.

Skill 변경은 **담당자 작성 → Branch → Pull Request → Reviewer Review → main Merge** 순서로 관리하며, 공통 정책 또는 고위험 변경은 필요 시 리더의 최종 판단을 거칩니다.
