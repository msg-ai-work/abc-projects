---
name: handover-readiness
description: 구축 결과가 운영 조직이 실제로 인수·운영 가능한 수준인지 아키텍처, Runbook, 알람, 배포/원복, 권한, Known Issue, 교육과 지원체계 기준으로 판정한다.
metadata:
  responsible-role: 담당자
  reviewer-role: Reviewer
  version: "1.0"
---

# Handover Readiness

문서가 존재하는지만 확인하지 않고, 운영자가 실제로 서비스 점검·배포·장애대응·복구를 수행할 수 있는지를 기준으로 인수 준비도를 판정한다.

## 사용할 때

- 프로젝트 완료 후 운영 조직 인계 전
- 신규 서비스/기능의 Hypercare 종료 전
- SI → SM 전환 시
- 운영 책임/지원범위/연락체계를 확정할 때

## 입력 계약

- 최신 Architecture / Interface 문서
- Cutover / Rollback 결과와 Known Issue
- 운영 Runbook / Monitoring / Alert 정보
- 배포/설정/권한 절차
- 유지보수/지원 범위와 연락체계

## 실행 절차

1. Architecture, Interface, Data Flow 문서가 실제 운영 상태와 일치하는지 확인한다.
2. Start/Stop/점검/배포/Rollback/재처리/장애대응 Runbook 존재와 실행 가능성을 확인한다.
3. Monitoring Dashboard, Alert, Threshold, 담당자와 Escalation 경로를 확인한다.
4. 계정, 권한, 인증서, Secret 인수 절차를 확인하되 Secret 원문을 문서에 저장하지 않는다.
5. 배포 Artifact/Version/Config 관리 방식과 변경 이력을 확인한다.
6. Known Issue, 제한사항, 임시조치, 기술부채와 향후 개선계획을 정리한다.
7. Backup/Restore/DR 절차와 최근 검증 Evidence를 확인한다.
8. 운영자가 대표 시나리오를 직접 수행하거나 설명할 수 있는지 확인한다.
9. 장애 연락망, 고객/외부 시스템 담당자, 유지보수/지원 범위를 명확히 한다.
10. 교육/Walkthrough/Q&A 결과와 미해결 인수 항목을 기록한다.
11. 인수 항목을 Ready/Conditional/Blocked로 판정하고 담당자/Due Date를 지정한다.
12. Hypercare 종료 및 프로젝트 종료 조건을 확인한다.

## Readiness Checklist

- [ ] Architecture / Interface 최신화
- [ ] 운영 Runbook 실행 가능
- [ ] Monitoring / Alert / Escalation 준비
- [ ] 배포 / Rollback 절차 검증
- [ ] 계정 / 권한 / 인증서 인수 절차
- [ ] Known Issue / 제한사항 공유
- [ ] Backup / DR Evidence
- [ ] 운영 교육 / 실습 완료
- [ ] 유지보수 / 지원 범위 확정
- [ ] 산출물 저장 위치와 담당자 확정

## 판정 기준

- `Ready`: 운영자가 핵심 운영업무를 독립 수행 가능
- `Conditional`: 제한사항이 있으나 담당자/기한/우회책이 승인됨
- `Blocked`: 장애대응, 배포/원복, 권한, 핵심 문서 중 하나라도 운영 수행을 막음

## 출력 계약

- Handover Inventory
- Document / Runbook Readiness
- Monitoring / Alert Readiness
- Access / Credential Handover Procedure
- Deployment / Rollback Readiness
- Known Issue / Technical Debt
- DR / Backup Evidence
- Training / Walkthrough Result
- Support / Escalation Matrix
- Blocking Item / 담당자 / Due Date
- Handover Decision & Rationale

## Human Gate

운영 인수 승인, Hypercare 종료, Known Issue 위험 수용은 운영 책임자와 프로젝트 책임자가 결정한다.

## 다음 Skill

- 미해결 운영 위험: `risk-issue-management`
- 추가 원복 검토: `rollback-plan`

## Self Check

- 문서가 아니라 실제 운영 수행 가능성을 확인했는가?
- 새 담당자가 장애 상황에서 누구에게 연락할지 알 수 있는가?
- 배포와 Rollback을 운영자가 재현할 수 있는가?
- Secret/개인정보 원문을 산출물에 저장하지 않았는가?
- 프로젝트 종료 후에도 Known Issue의 담당자가 남아 있는가?
