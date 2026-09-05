$ErrorActionPreference = 'Stop'

$fixtureRoot = 'evals/stages'
$fixtures = @(Get-ChildItem $fixtureRoot -Filter '*.json' -File | Sort-Object Name)
if ($fixtures.Count -ne 7) {
  Write-Error "Expected 7 stage fixtures, found $($fixtures.Count)."
  exit 1
}

$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("abc-project-stage-evals-" + [guid]::NewGuid().ToString('N'))
$failures = @()

try {
  New-Item -ItemType Directory -Force -Path $tempRoot | Out-Null

  foreach ($fixtureFile in $fixtures) {
    $fixture = Get-Content $fixtureFile.FullName -Raw | ConvertFrom-Json
    $stageRoot = Join-Path $tempRoot $fixture.stage
    $passRoot = Join-Path $stageRoot 'pass'
    $failRoot = Join-Path $stageRoot 'fail'
    New-Item -ItemType Directory -Force -Path $passRoot,$failRoot | Out-Null

    Set-Content -Path (Join-Path $passRoot $fixture.file) -Value $fixture.passContent -Encoding UTF8
    Set-Content -Path (Join-Path $failRoot $fixture.file) -Value $fixture.failContent -Encoding UTF8

    $passOutput = & pwsh -NoProfile -File scripts/quality-gate.ps1 -Root $passRoot 2>&1 | Out-String
    $passExit = $LASTEXITCODE
    if ($passExit -ne 0) {
      $failures += "$($fixture.stage) PASS fixture failed unexpectedly: $passOutput"
    } else {
      Write-Output "PASS $($fixture.stage) positive fixture"
    }

    $failOutput = & pwsh -NoProfile -File scripts/quality-gate.ps1 -Root $failRoot 2>&1 | Out-String
    $failExit = $LASTEXITCODE
    if ($failExit -eq 0) {
      $failures += "$($fixture.stage) FAIL fixture passed unexpectedly"
    } elseif ($failOutput -notmatch "\[$([regex]::Escape($fixture.expectedFailCode))\]") {
      $failures += "$($fixture.stage) expected [$($fixture.expectedFailCode)] but output was: $failOutput"
    } else {
      Write-Output "PASS $($fixture.stage) negative fixture -> [$($fixture.expectedFailCode)]"
    }
  }
}
finally {
  if (Test-Path $tempRoot) { Remove-Item $tempRoot -Recurse -Force }
}

if ($failures.Count -gt 0) {
  $failures | ForEach-Object { Write-Error $_ }
  exit 1
}

Write-Output 'Seven-stage evals: PASS (14/14 cases)'
