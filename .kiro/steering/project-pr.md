---
inclusion: manual
---
# /project-pr

프로젝트 Worktree의 변경을 PR로 올리는 절차다.

1. 프로젝트 ID에 대응하는 Worktree를 찾는다.
2. `git status`, `git diff`로 변경 범위를 검토한다.
3. `scripts/quality-gate.ps1 -ProjectId <id>`가 실패하면 중단한다.
4. Secret/개인정보/운영 credential 포함 여부를 점검한다.
5. 사람이 검토할 수 있도록 변경 요약을 제시한다.
6. 승인 후 Commit/Push한다.
7. GitHub MCP가 설정된 경우 PR을 생성하고 base는 project-config의 release.base_branch를 사용한다.
8. PR Body에 변경 산출물, Gate 결과, Risk/Decision, Jira/Confluence 근거를 포함한다.

Production 배포는 이 명령의 범위가 아니다.
