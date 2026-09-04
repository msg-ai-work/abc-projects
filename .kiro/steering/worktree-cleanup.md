---
inclusion: manual
---
# /worktree-cleanup

PR Merge 이후에만 Worktree를 정리한다.

1. PR이 Merge되었는지 확인한다.
2. 미커밋 변경이 있으면 중단한다.
3. `scripts/worktree-cleanup.ps1 -ProjectId <id>`를 실행한다.
4. Worktree 제거와 로컬 브랜치 삭제 결과를 보고한다.
5. 원격 브랜치 삭제는 Repository 정책에 따라 선택한다.

Merge 전 또는 미커밋 변경 상태에서는 강제 삭제하지 않는다.
