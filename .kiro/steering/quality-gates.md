---
inclusion: always
---
# Project Quality Gates

| Gate Code | Gate | PASS 최소조건 | 실패 시 복귀 |
|---|---|---|---|
| SCOPE | Scope | In/Out Scope, Success Criteria, Stakeholder, Open Decision 명시 | 01 |
| REQUIREMENT | Requirement | 모든 핵심 요구 ID/AC 존재, 미결정 요구 분리 | 02 |
| ARCHITECTURE | Architecture/Integration | AS-IS/TO-BE 영향, Timeout/Retry/Idempotency, Critical Unknown 관리 | 03 |
| DELIVERY | Delivery | Dependency/담당자/Due Date, Migration 정합성/검증/원복 연결 | 04 |
| TEST | Test | Traceability, 환경/데이터, Threshold, Evidence, Critical Defect=0 | 02~05 원인별 |
| CUTOVER | Cutover | Go/No-Go 기준, Monitoring, Rollback Trigger, Hypercare 정의 | 06 |
| HANDOVER | Handover | Runbook/Alarm/권한/Known Issue/교육/지원범위/Human Acceptance | 07 |

## Rework Limit
- 동일 Gate의 `failure_count=1~3`: 해당 Agent로 REWORK
- 동일 Gate의 `failure_count=4`: 자동 재작업 중단
- 4번째 실패 Fail Code: `REWORK_LIMIT`
- 4번째 실패 Decision: `ESCALATE`
- Escalation 후 추가 진행은 사람 결정 필요

## 공통 Fail 조건
- 근거 없이 PASS 처리
- 승인 증적 없는 다음 단계 진행
- Critical/High Risk를 숨기거나 자동 Accepted 처리
- Production 실행을 AI가 승인
- Secret/개인정보 원문을 Repository에 저장
