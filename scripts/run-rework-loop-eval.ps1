$ErrorActionPreference = 'Stop'

$expected = @(
  @{ FailureCount = 1; Decision = 'REWORK'; FailCode = 'ARCHITECTURE'; Agent = '03-architecture' },
  @{ FailureCount = 2; Decision = 'REWORK'; FailCode = 'ARCHITECTURE'; Agent = '03-architecture' },
  @{ FailureCount = 3; Decision = 'REWORK'; FailCode = 'ARCHITECTURE'; Agent = '03-architecture' },
  @{ FailureCount = 4; Decision = 'ESCALATE'; FailCode = 'REWORK_LIMIT'; Agent = $null }
)

$failures = @()
foreach ($case in $expected) {
  $json = & pwsh -NoProfile -File scripts/rework-loop-policy.ps1 -GateCode ARCHITECTURE -FailureCount $case.FailureCount -MaxReworks 3 -AsJson
  if ($LASTEXITCODE -ne 0) {
    $failures += "failure_count=$($case.FailureCount): policy command failed"
    continue
  }

  $actual = $json | ConvertFrom-Json
  if ($actual.decision -ne $case.Decision) {
    $failures += "failure_count=$($case.FailureCount): expected decision $($case.Decision), got $($actual.decision)"
  }
  if ($actual.fail_code -ne $case.FailCode) {
    $failures += "failure_count=$($case.FailureCount): expected fail_code $($case.FailCode), got $($actual.fail_code)"
  }
  if ($case.Agent -and $actual.rework_agent -ne $case.Agent) {
    $failures += "failure_count=$($case.FailureCount): expected agent $($case.Agent), got $($actual.rework_agent)"
  }
  if (-not $case.Agent -and $actual.rework_agent) {
    $failures += "failure_count=$($case.FailureCount): escalation must not return an automatic rework agent"
  }

  Write-Output "PASS failure_count=$($case.FailureCount) decision=$($actual.decision) fail_code=$($actual.fail_code)"
}

if ($failures.Count -gt 0) {
  $failures | ForEach-Object { Write-Error $_ }
  exit 1
}

Write-Output 'Rework loop eval: PASS (3 reworks + 4th failure escalation)'
