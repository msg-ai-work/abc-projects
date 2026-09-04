param([Parameter(Mandatory=$true)][string]$ProjectId,[Parameter(Mandatory=$true)][string]$Slug,[string]$BaseBranch='main',[string]$Root='../abc-projects-worktrees')
$ErrorActionPreference='Stop'
$branch="project/$ProjectId/$Slug"
$path=Join-Path $Root "$ProjectId-$Slug"
git fetch origin $BaseBranch
if ($LASTEXITCODE -ne 0) { throw 'git fetch failed' }
git worktree add -b $branch $path "origin/$BaseBranch"
if ($LASTEXITCODE -ne 0) { throw 'git worktree add failed' }
Write-Output "Worktree: $path"
Write-Output "Branch: $branch"
