---
inclusion: always
---
# Project Quality Gates

| Gate | PASS 최소조건 | 실패 시 복귀 |
|---|---|---|
| Scope | In/Out Scope, Success Criteria, Stakeholder, Open Decision 명시 | 01 |
| Requirement | 모든 핵심 요구 ID/AC 존재, 미결정 요구 분리 | 02 |
| Architecture | AS-IS 근거, TO-BE 영향, Critical Unknown=0, Rollback 영향 정의 | 03 |
| Integration | Timeout/Retry/Idempotency/Error/재처리/Owner 정의 | 03 |
| Delivery | Dependency/Owner/Due Date, Migration 정합성/검증/원복 연결 | 04 |
| Test | Traceability, 환경/데이터, Threshold, Evidence, Critical Defect=0 | 02~05 원인별 |
| Cutover | Go/No-Go 기준, Monitoring, Rollback Trigger, Hypercare 정의 | 06 |
| Handover | Runbook/Alarm/권한/Known Issue/교육 Evidence | 07 |

## 공통 Fail 조건
- 근거 없이 PASS 처리
- 승인 증적 없는 다음 단계 진행
- Critical/High Risk를 숨기거나 자동 Accepted 처리
- Production 실행을 AI가 승인
- Secret/개인정보 원문을 Repository에 저장
