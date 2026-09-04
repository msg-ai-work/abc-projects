---
inclusion: always
---
# Evidence Policy

결론은 가능한 한 Evidence에 연결한다.

허용 Evidence 예: Jira/Confluence 결정, Git diff/commit/PR, 테스트 결과, 성능 리포트, 로그 요약, 운영 검증 체크리스트, 승인 기록.

규칙:
- Evidence가 없으면 Fact가 아니라 Assumption/Unknown으로 표시한다.
- Secret, 인증토큰, 개인정보 원문 로그는 Evidence로 Repository에 저장하지 않는다.
- 링크만으로 완료 처리하지 말고 무엇을 검증했는지 한 줄 요약을 남긴다.
- 산출물에는 `Evidence`, `Open Decision`, `Risk`, `Next Action` 섹션을 기본 포함한다.
