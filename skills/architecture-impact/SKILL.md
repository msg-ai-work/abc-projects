---
name: architecture-impact
summary: 프로젝트 변경이 기업메시징 아키텍처와 운영에 미치는 영향을 분석한다.
version: "0.1"
---
# Architecture Impact
## 확인 영역
- Application/Component
- API/Event/Batch
- DB/Cache/Queue
- Network/Security
- Capacity/Performance
- Monitoring/Operation
- DR/Backup
## 절차
1. AS-IS 흐름을 식별한다.
2. TO-BE 변경 지점을 표시한다.
3. 직접/간접 영향 시스템을 나열한다.
4. 호환성, 용량, 장애전파, Rollback 영향을 평가한다.
5. 결정이 필요한 항목은 ADR 후보로 분리한다.
