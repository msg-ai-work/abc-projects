# SALL Forge ↔ ABC Project Forge 1:1 Mapping

| SALL Forge | ABC Project Forge | 설명 |
|---|---|---|
| team-config.md | project-config.md | 팀/프로젝트별 차이 1개 파일로 선언 |
| Main Orchestrator | project-orchestrator | 체인/DAG/Loop 관리 |
| 01 Task 분석 | 01 Project Intake | 목적/범위/R&R |
| 02 Legacy 분석 | 02 Requirement + 03 Architecture | 현행과 요구/영향 분석 |
| 03 FE 구현 | 04 Delivery/Migration | 프로젝트 실행/전환 계획. 실제 구현은 abc-engine/web/tech-support Harness에 위임 |
| 04 QA | 05 Test Readiness | 통합/UAT/성능/보안 준비도와 Evidence |
| 04b Auto Fixer | Rework Loop | 원인별 02~06 Agent 재호출 |
| 05 Test Guide | 06 Cutover + 07 Handover | 오픈/원복/운영이관까지 확대 |
| QA 85% Gate | Project Quality Gates | Scope/Traceability/Risk/Ready/Go-NoGo 기준 |
| ECC Agent/Skill | abc Common Harness + Domain Skills | 공통 품질과 프로젝트 지식을 분리 |
| Hooks | Kiro v1 hooks | SessionStart/PostFileSave 기반 자동 검증 |
| Worktree | Worktree | 프로젝트 병렬 격리 |
| GitHub MCP PR | /project-pr | 검토 후 PR 생성 |

## 가장 큰 차이
SALL Forge는 코드 Task Factory이고 ABC Project Forge는 `Scope→Requirement→Architecture→Migration→Test→Cutover→Handover`를 다루는 Enterprise SI Project Factory다.
