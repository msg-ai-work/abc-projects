param([Parameter(Mandatory=$true)][string]$ProjectId,[string]$Root='../abc-projects-worktrees')
$ErrorActionPreference='Stop'
$matches=Get-ChildItem $Root -Directory -Filter "$ProjectId-*" -ErrorAction SilentlyContinue
if ($matches.Count -ne 1) { throw "Expected exactly one worktree for $ProjectId, found $($matches.Count)." }
$path=$matches[0].FullName
$status=git -C $path status --porcelain
if ($status) { throw 'Uncommitted changes exist. Cleanup stopped.' }
$branch=(git -C $path branch --show-current).Trim()
git worktree remove $path
if ($LASTEXITCODE -ne 0) { throw 'worktree remove failed' }
git branch -d $branch
Write-Output "Removed worktree and local branch: $branch"
