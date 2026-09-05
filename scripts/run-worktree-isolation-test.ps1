param(
  [string]$Root = ''
)

$ErrorActionPreference = 'Stop'
$repoRoot = (Get-Location).Path
if (-not $Root) {
  $Root = Join-Path (Split-Path $repoRoot -Parent) 'abc-projects-worktrees-eval'
}
$rootFull = [System.IO.Path]::GetFullPath($Root)
$stamp = Get-Date -Format 'yyyyMMddHHmmssfff'
$projectA = "WT-A-$stamp"
$projectB = "WT-B-$stamp"
$slugA = 'alpha'
$slugB = 'beta'
$pathA = Join-Path $rootFull "$projectA-$slugA"
$pathB = Join-Path $rootFull "$projectB-$slugB"
$branchA = "project/$projectA/$slugA"
$branchB = "project/$projectB/$slugB"
$failed = $false

function Assert-True([bool]$Condition, [string]$Message) {
  if (-not $Condition) { throw $Message }
}

function Remove-TestArtifacts([string]$WorktreePath, [string]$ProjectId, [string]$Marker) {
  if (-not (Test-Path $WorktreePath)) { return }
  $markerPath = Join-Path $WorktreePath $Marker
  if (Test-Path $markerPath) { Remove-Item $markerPath -Force }
  $projectPath = Join-Path $WorktreePath "docs/projects/$ProjectId"
  if (Test-Path $projectPath) { Remove-Item $projectPath -Recurse -Force }
}

try {
  New-Item -ItemType Directory -Force -Path $rootFull | Out-Null

  & pwsh -NoProfile -File scripts/worktree-create.ps1 -ProjectId $projectA -Slug $slugA -Root $rootFull
  Assert-True ($LASTEXITCODE -eq 0) 'worktree A creation failed'

  & pwsh -NoProfile -File scripts/worktree-create.ps1 -ProjectId $projectB -Slug $slugB -Root $rootFull
  Assert-True ($LASTEXITCODE -eq 0) 'worktree B creation failed'

  Assert-True (Test-Path $pathA) 'worktree A path missing'
  Assert-True (Test-Path $pathB) 'worktree B path missing'
  Assert-True (((git -C $pathA branch --show-current).Trim()) -eq $branchA) 'worktree A branch mismatch'
  Assert-True (((git -C $pathB branch --show-current).Trim()) -eq $branchB) 'worktree B branch mismatch'

  Set-Content -Path (Join-Path $pathA 'ISOLATION-A.txt') -Value $projectA -Encoding UTF8
  Set-Content -Path (Join-Path $pathB 'ISOLATION-B.txt') -Value $projectB -Encoding UTF8

  Assert-True (Test-Path (Join-Path $pathA 'ISOLATION-A.txt')) 'A marker missing from A'
  Assert-True (-not (Test-Path (Join-Path $pathA 'ISOLATION-B.txt'))) 'B marker leaked into A'
  Assert-True (Test-Path (Join-Path $pathB 'ISOLATION-B.txt')) 'B marker missing from B'
  Assert-True (-not (Test-Path (Join-Path $pathB 'ISOLATION-A.txt'))) 'A marker leaked into B'
  Write-Output 'PASS isolation: two worktrees do not share uncommitted changes'

  $gateRoot = Join-Path $pathA "docs/projects/$projectA"
  New-Item -ItemType Directory -Force -Path $gateRoot | Out-Null
  @'
# Requirement Runtime Fixture
- Project ID: WORKTREE-GATE
- Status: Draft

## Requirements
- REQ-001: test-only requirement without executable acceptance definition

## Evidence
- worktree isolation runtime test
'@ | Set-Content -Path (Join-Path $gateRoot '02-REQUIREMENT.md') -Encoding UTF8

  $gateOutput = & pwsh -NoProfile -File scripts/quality-gate.ps1 -Root $gateRoot 2>&1 | Out-String
  $gateExit = $LASTEXITCODE
  Assert-True ($gateExit -ne 0) 'Quality Gate should block the intentionally invalid project artifact'
  Assert-True ($gateOutput -match '\[REQUIREMENT\]') 'Quality Gate did not return REQUIREMENT failure'
  Write-Output 'PASS PR precondition: invalid artifact is blocked by Quality Gate'

  $dirtyOutput = & pwsh -NoProfile -File scripts/worktree-cleanup.ps1 -ProjectId $projectA -Root $rootFull 2>&1 | Out-String
  $dirtyExit = $LASTEXITCODE
  Assert-True ($dirtyExit -ne 0) 'cleanup must fail while uncommitted changes exist'
  Assert-True (Test-Path $pathA) 'dirty cleanup unexpectedly removed worktree A'
  Write-Output 'PASS cleanup guard: dirty worktree was not removed'

  Remove-TestArtifacts -WorktreePath $pathA -ProjectId $projectA -Marker 'ISOLATION-A.txt'
  Remove-TestArtifacts -WorktreePath $pathB -ProjectId $projectB -Marker 'ISOLATION-B.txt'

  Assert-True (-not (git -C $pathA status --porcelain)) 'worktree A should be clean before cleanup'
  Assert-True (-not (git -C $pathB status --porcelain)) 'worktree B should be clean before cleanup'

  & pwsh -NoProfile -File scripts/worktree-cleanup.ps1 -ProjectId $projectA -Root $rootFull
  Assert-True ($LASTEXITCODE -eq 0) 'worktree A cleanup failed'
  & pwsh -NoProfile -File scripts/worktree-cleanup.ps1 -ProjectId $projectB -Root $rootFull
  Assert-True ($LASTEXITCODE -eq 0) 'worktree B cleanup failed'

  Assert-True (-not (Test-Path $pathA)) 'worktree A path remains after cleanup'
  Assert-True (-not (Test-Path $pathB)) 'worktree B path remains after cleanup'
  Write-Output 'Worktree isolation eval: PASS (2 worktrees + gate block + dirty cleanup guard + safe cleanup)'
}
catch {
  $failed = $true
  Write-Error $_
}
finally {
  foreach ($item in @(
    @{ Path = $pathA; Project = $projectA; Marker = 'ISOLATION-A.txt'; Branch = $branchA },
    @{ Path = $pathB; Project = $projectB; Marker = 'ISOLATION-B.txt'; Branch = $branchB }
  )) {
    if (Test-Path $item.Path) {
      Remove-TestArtifacts -WorktreePath $item.Path -ProjectId $item.Project -Marker $item.Marker
      $status = git -C $item.Path status --porcelain
      if (-not $status) {
        git worktree remove $item.Path 2>$null | Out-Null
        git branch -d $item.Branch 2>$null | Out-Null
      } else {
        Write-Warning "Manual cleanup required; worktree remains dirty: $($item.Path)"
      }
    }
  }
  if ((Test-Path $rootFull) -and -not (Get-ChildItem $rootFull -Force -ErrorAction SilentlyContinue)) {
    Remove-Item $rootFull -Force
  }
}

if ($failed) { exit 1 }
