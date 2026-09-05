# Phase 3 Runtime Test — Parallel Worktree Isolation

## 목적
두 프로젝트 Worktree를 동시에 생성해 변경이 서로 섞이지 않는지, Quality Gate 실패 시 PR 전 단계에서 차단되는지, dirty Worktree가 안전하게 보존되는지 검증한다.

## 자동 실행

Repository root에서:

```powershell
pwsh -NoProfile -File scripts/run-worktree-isolation-test.ps1
```

자동 테스트는 매 실행마다 고유 Project ID를 생성한다.

검증 항목:
1. `project/<project-id>/<slug>` 브랜치 2개 생성
2. Worktree A/B 경로 2개 동시 생성
3. A 전용 marker가 B에 보이지 않고 B marker가 A에 보이지 않음
4. A에 의도적 REQUIREMENT 결함을 만들고 `quality-gate.ps1`이 PR 전 단계에서 차단
5. 미커밋 변경이 있는 A에 cleanup 실행 시 실패하며 Worktree가 유지됨
6. 테스트 산출물을 제거해 clean 상태로 만든 뒤 A/B 모두 정상 cleanup
7. Worktree 경로와 local branch가 안전하게 제거됨

기대 마지막 출력:

```text
PASS isolation: two worktrees do not share uncommitted changes
PASS PR precondition: invalid artifact is blocked by Quality Gate
PASS cleanup guard: dirty worktree was not removed
Worktree isolation eval: PASS (2 worktrees + gate block + dirty cleanup guard + safe cleanup)
```

## Kiro Runtime Test 프롬프트

```text
Phase 3 Worktree Isolation Runtime Test를 수행해줘.

1. `workflows/worktree-pr.md`, `.kiro/steering/project-pr.md`, `.kiro/steering/worktree-cleanup.md`를 먼저 읽는다.
2. `pwsh -NoProfile -File scripts/run-worktree-isolation-test.ps1`을 실행한다.
3. 두 Worktree의 branch/path가 서로 다른지 확인한다.
4. marker 격리 검증 결과를 Evidence로 남긴다.
5. 의도적 Requirement 결함이 Quality Gate에서 REQUIREMENT로 차단되는지 확인한다.
6. dirty Worktree cleanup 시도가 실패하고 Worktree가 유지되는지 확인한다.
7. 테스트가 끝난 뒤 두 Worktree와 local branch가 안전하게 제거됐는지 확인한다.
8. Force delete, Production 배포, 실제 고객 데이터, Secret 사용은 금지한다.

종료 시 아래 표를 출력한다.

| 항목 | 결과 | Evidence |
|---|---|---|
| Worktree A 생성 | PASS/FAIL | branch/path |
| Worktree B 생성 | PASS/FAIL | branch/path |
| 변경 격리 | PASS/FAIL | marker 검증 |
| Quality Gate PR 차단 | PASS/FAIL | REQUIREMENT output |
| Dirty Cleanup Guard | PASS/FAIL | cleanup exit/output |
| Safe Cleanup | PASS/FAIL | worktree/branch 제거 확인 |
```

## Issue #5 완료를 위한 추가 Evidence

이 테스트는 Phase 3 완료조건 중 다음을 자동 검증한다.
- 2개 이상의 Project Worktree 동시 생성
- 서로의 변경 미혼합
- Quality Gate 실패 시 PR 생성 전 중단
- 미커밋 변경 Worktree 정리 금지
- 정상 clean 상태의 안전한 Worktree/local branch 정리

실제 GitHub PR 생성/Push Evidence와 PR Body의 Project ID/Risk/Gate 포함 검증은 별도 Kiro `/project-pr` Runtime 실행으로 남긴다.
