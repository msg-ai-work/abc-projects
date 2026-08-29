---
name: integration-design
summary: 고객사 또는 외부 시스템과의 API/File/DB/Event 연계를 설계·검토한다.
version: "0.1"
---
# Integration Design
## 절차
1. Source/Target과 연계 목적을 정의한다.
2. Protocol, Format, Schema, Encoding을 확인한다.
3. 인증/암호화/Network 경계를 확인한다.
4. Timeout/Retry/Idempotency/Error Code를 정의한다.
5. 트래픽/배치량/피크 용량을 확인한다.
6. 장애 시 재처리와 운영 책임을 정의한다.
## 출력
Interface Contract, Error Handling, Security, Capacity, Operation Rule.
