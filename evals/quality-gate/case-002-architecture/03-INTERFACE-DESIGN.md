# Interface Design Fixture — Missing Resilience Contract

Status: Draft

## Interface
- Source: web
- Target: messaging-engine
- Protocol: HTTPS/JSON
- Authentication: mTLS

## Evidence
- fixture: case-002-architecture

## Expected Gate
- FAIL CODE: `ARCHITECTURE`
- Reason: Timeout / Retry / Idempotency contract missing
