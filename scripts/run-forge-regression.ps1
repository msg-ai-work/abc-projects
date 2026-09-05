param(
  [switch]$IncludeWorktree
)

$ErrorActionPreference = 'Stop'
$steps = @(
  @{ Name = 'Quality Gate negative fixtures'; Script = 'scripts/run-quality-gate-evals.ps1' },
  @{ Name = 'Rework loop policy'; Script = 'scripts/run-rework-loop-eval.ps1' },
  @{ Name = 'Seven-stage pass/fail evals'; Script = 'scripts/run-stage-evals.ps1' }
)

foreach ($step in $steps) {
  Write-Output "=== $($step.Name) ==="
  & pwsh -NoProfile -File $step.Script
  if ($LASTEXITCODE -ne 0) {
    Write-Error "$($step.Name) failed"
    exit 1
  }
}

if ($IncludeWorktree) {
  Write-Output '=== Parallel Worktree Isolation ==='
  & pwsh -NoProfile -File scripts/run-worktree-isolation-test.ps1
  if ($LASTEXITCODE -ne 0) {
    Write-Error 'Parallel Worktree Isolation failed'
    exit 1
  }
}

Write-Output "Forge regression: PASS (IncludeWorktree=$IncludeWorktree)"
