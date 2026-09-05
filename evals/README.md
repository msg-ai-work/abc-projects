# Project Evaluations

ABC Project Forge의 Skill/Agent/Gate가 기대한 계획, 판단, 검증 결과를 재현하는지 Eval로 관리한다.

## 현재 Eval 구성

```text
evals/
  quality-gate/        # 기존 의도적 실패 5종
  stages/              # 01~07 PASS/FAIL 14 cases
```

### Quality Gate 실패 Fixture

```powershell
pwsh -NoProfile -File scripts/run-quality-gate-evals.ps1
```

### 7-Stage PASS/FAIL Fixture

```powershell
pwsh -NoProfile -File scripts/run-stage-evals.ps1
```

### Rework Loop 정책

```powershell
pwsh -NoProfile -File scripts/run-rework-loop-eval.ps1
```

### 통합 Regression

```powershell
pwsh -NoProfile -File scripts/run-forge-regression.ps1
```

Worktree Runtime까지 포함:

```powershell
pwsh -NoProfile -File scripts/run-forge-regression.ps1 -IncludeWorktree
```

## 원칙

- 실제 고객/프로젝트 데이터를 사용할 경우 개인정보, 계정, IP, Token 등 민감정보를 반드시 Masking한다.
- Fixture의 기대 결과 설명은 실제 Gate 입력과 분리해 self-match/false PASS를 방지한다.
- Skill/Agent/Gate 변경 PR은 동일 Fixture로 변경 전/후 회귀를 비교한다.
- Runtime/CI Evidence 없는 항목은 완료로 과대평가하지 않는다.
