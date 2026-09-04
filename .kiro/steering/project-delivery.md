---
inclusion: manual
---
# /project-delivery

`workflows/project-delivery.md`를 실행 계약으로 사용한다.

1. project-config와 프로젝트 ID를 확인한다.
2. scripts/preflight-check.ps1을 실행한다.
3. project-orchestrator를 중심으로 01~07 Sub Agent DAG를 실행한다.
4. 각 단계 Quality Gate와 Human Gate를 확인한다.
5. 실패 시 원인 단계로 최대 3회 Loop한다.
6. 최종 Project Report와 열린 Risk/Decision을 요약한다.

사용 예: `/project-delivery SAMPLE-MSG-2026`
