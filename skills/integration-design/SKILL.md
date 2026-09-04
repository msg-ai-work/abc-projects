---
name: integration-design
description: 고객사 또는 외부 시스템과의 API/File/DB/Event 연계를 계약, 오류처리, 보안, 용량, 재처리, 운영 책임까지 포함해 설계·검토한다.
metadata:
  owner: projects
  version: "1.0"
---

# Integration Design

외부 연계를 단순 필드 매핑이 아니라 실패와 운영까지 포함하는 실행 가능한 Interface Contract로 만든다.

## 사용할 때

- 고객사/외부 시스템 신규 연계 또는 변경 시
- API, File, DB, Event/Kafka 연계 설계 시
- Timeout/Retry/중복처리/오류코드 기준이 필요한 경우
- 운영 장애 시 재처리 책임을 정해야 할 때

## 입력 계약

- 승인된 요구사항
- `architecture-impact` 결과 또는 동등한 영향 분석
- Source/Target 시스템 정보
- 기존 Interface 문서, Schema, 샘플 데이터
- 인증/네트워크/보안 정책

## 실행 절차

1. Source, Target, 연계 목적과 성공의 의미를 정의한다.
2. Protocol, Endpoint/Topic/File 경로, Format, Schema, Encoding, Version을 정의한다.
3. 필수/선택 필드, Default, Code Mapping, Null 처리, 시간대/날짜 형식을 확인한다.
4. 인증, 권한, 암호화, 인증서, Network 경계를 확인한다.
5. Timeout, Retry, Backoff, Circuit Breaker 필요성을 정의한다.
6. Idempotency, 중복처리, 순서보장, 재전송 기준을 정의한다.
7. 성공/실패 응답과 Error Code를 업무 오류/시스템 오류로 구분한다.
8. TPS, 평균/피크 트래픽, 메시지 크기, 배치량, 동시성 제한을 확인한다.
9. 장애 시 저장, 재처리, DLQ/보정, 수동 복구 절차와 책임 주체를 정의한다.
10. Monitoring, Alert, Trace/Correlation ID, 로그 마스킹과 Evidence 기준을 정의한다.
11. 호환성/Version 변경 시 Consumer 영향과 전환 방식을 확인한다.

## 중단 조건

다음이 불명확하면 연계 설계 완료로 보지 않는다.

- 성공의 의미와 처리 완료 시점
- 인증/Network 접근 방식
- Timeout/Retry/중복 처리 기준
- Error Code와 재처리 책임
- 피크 용량 또는 메시지 크기
- 개인정보/민감정보 전달과 마스킹 기준

## 출력 계약

- Interface Overview
- Source / Target / Owner
- Protocol / Contract / Schema
- Field & Code Mapping
- Authentication / Security
- Timeout / Retry / Idempotency / Ordering
- Error Handling
- Capacity
- Reprocessing / Recovery
- Monitoring / Evidence
- Compatibility / Versioning
- Open Question / Risk

## Human Gate

AI는 외부 시스템 계약, 보안 예외, 운영 책임을 확정하지 않는다. 계약 변경과 위험 수용은 관련 책임자가 승인한다.

## 다음 Skill

- 전환 필요 시: `migration-plan`
- 시험 준비: `test-readiness`
- 영향 재검토: `architecture-impact`
- 이슈 추적: `risk-issue-management`

## Self Check

- 정상 흐름보다 실패 흐름이 충분히 정의되어 있는가?
- 중복발송/중복처리 가능성이 제거 또는 통제되는가?
- 피크 트래픽에서 Timeout/Retry 폭증 위험을 검토했는가?
- 장애 후 누가 무엇을 재처리하는지 명확한가?
- 운영자가 Trace ID로 End-to-End 추적할 수 있는가?
