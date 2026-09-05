$ErrorActionPreference = 'Stop'

$cases = @(
  @{ Name = 'case-001-requirement'; Code = 'REQUIREMENT' },
  @{ Name = 'case-002-architecture'; Code = 'ARCHITECTURE' },
  @{ Name = 'case-003-delivery'; Code = 'DELIVERY' },
  @{ Name = 'case-004-test'; Code = 'TEST' },
  @{ Name = 'case-005-cutover'; Code = 'CUTOVER' }
)

$failed = @()
foreach ($case in $cases) {
  $root = "evals/quality-gate/$($case.Name)"
  $output = & pwsh -NoProfile -File scripts/quality-gate.ps1 -Root $root 2>&1 | Out-String
  $exitCode = $LASTEXITCODE

  if ($exitCode -eq 0) {
    $failed += "$($case.Name): expected failure but gate passed"
    continue
  }

  if ($output -notmatch "\[$($case.Code)\]") {
    $failed += "$($case.Name): expected code $($case.Code) not found"
    continue
  }

  Write-Output "PASS $($case.Name) -> expected [$($case.Code)] failure detected"
}

if ($failed.Count -gt 0) {
  $failed | ForEach-Object { Write-Error $_ }
  exit 1
}

Write-Output "Quality gate evals: PASS ($($cases.Count)/$($cases.Count))"
