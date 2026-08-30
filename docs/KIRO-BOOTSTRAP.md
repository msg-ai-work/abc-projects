# Kiro Bootstrap

`bootstrap-harness`는 중앙 `msg-ai-work/abc`를 `.ai-harness/common`에 동기화한다. `enterprise-messaging-projects` Agent는 중앙 Steering/Rule/Common Skill과 로컬 Project Skill을 동시에 Resources로 읽는다.

## 실행
```powershell
./scripts/bootstrap-harness.ps1
```
또는
```bash
bash scripts/bootstrap-harness.sh
```

Kiro Agent picker에서 `enterprise-messaging-projects`를 선택한다.

초기에는 `harness.yaml`의 `ref: main`을 사용하고 안정화 후 `v1.0.0` 같은 Tag로 Pin한다. 고객별 Secret/개인정보는 저장하지 않으며 Go/No-Go, Production 전환, Rollback은 Human Gate를 유지한다.
