# Worktree / PR Workflow

## 원칙
AI 작업을 메인 디렉토리와 분리하고 사람이 검토한 뒤 PR로 병합한다.

## Naming
- Branch: `project/<project-id>/<slug>`
- Worktree: `<worktree_root>/<project-id>-<slug>`

## 생성
```powershell
pwsh -NoProfile -File scripts/worktree-create.ps1 -ProjectId SAMPLE-MSG-2026 -Slug rcs-integration
```

## PR 전 Gate
1. diff 확인
2. Quality Gate
3. Secret/개인정보 검사
4. Risk/Decision 요약
5. Commit/Push
6. GitHub MCP로 PR 생성

## Cleanup
PR Merge 확인 후:
```powershell
pwsh -NoProfile -File scripts/worktree-cleanup.ps1 -ProjectId SAMPLE-MSG-2026
```
강제 삭제는 기본값으로 사용하지 않는다.
