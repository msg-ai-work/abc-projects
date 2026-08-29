---
name: cutover-plan
summary: 프로젝트 오픈 시각부터 서비스 안정화까지의 실행 순서와 Go/No-Go 기준을 정의한다.
version: "0.1"
---
# Cutover Plan
## 절차
1. 사전 작업/Freeze/Backup을 정의한다.
2. 작업 순서와 담당자/예상시간을 지정한다.
3. 각 단계 완료 Evidence를 정의한다.
4. Go/No-Go Checkpoint를 배치한다.
5. 오픈 후 데이터/발송/빌링/모니터링 검증을 정의한다.
6. Hypercare와 Escalation 체계를 정의한다.
## Human Gate
Go/No-Go와 Production 전환 결정은 사람이 승인한다.
