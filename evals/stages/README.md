# Seven-Stage Gate Evals

ABC Project Forge 01~07 전체 Stage의 Quality Gate를 재현 가능하게 검증한다.

각 JSON Fixture는 실제 Gate 입력과 기대값을 분리한다.
- `file`: Gate가 읽을 산출물 파일명
- `passContent`: 정상 사례
- `failContent`: 의도적 결함 사례
- `expectedFailCode`: 실패 사례에서 기대하는 표준 Gate Code

`expectedFailCode`는 Gate 입력 파일에 쓰지 않으므로 Fixture 설명이 검사 키워드를 포함해 false PASS를 만드는 문제를 방지한다.

| Stage | PASS/FAIL | 기대 실패코드 |
|---|---:|---|
| 01 Project Intake | 2 | SCOPE |
| 02 Requirement | 2 | REQUIREMENT |
| 03 Architecture/Integration | 2 | ARCHITECTURE |
| 04 Delivery | 2 | DELIVERY |
| 05 Test Readiness | 2 | TEST |
| 06 Cutover | 2 | CUTOVER |
| 07 Handover | 2 | HANDOVER |
| **합계** | **14 cases** | |

실행:

```powershell
pwsh -NoProfile -File scripts/run-stage-evals.ps1
```

모든 PASS Fixture는 exit code 0이어야 하며, 모든 FAIL Fixture는 exit code 1과 기대 Gate Code를 반환해야 한다.
