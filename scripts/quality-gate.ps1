param([string]$ProjectId = '')
$ErrorActionPreference = 'Stop'
$root = if ($ProjectId) { "docs/projects/$ProjectId" } else { 'docs/projects' }
if (-not (Test-Path $root)) { Write-Output "Quality gate: no project artifact directory yet ($root)"; exit 0 }
$files = Get-ChildItem $root -Filter '*.md' -Recurse -ErrorAction SilentlyContinue
$fail = @()
foreach ($f in $files) {
  $text = Get-Content $f.FullName -Raw
  if ($text -match 'Status:\s*Approved' -and $text -notmatch 'Evidence') { $fail += "$($f.Name): Approved without Evidence section" }
  if ($text -match '<YOUR_TOKEN|ghp_[A-Za-z0-9]+') { $fail += "$($f.Name): possible credential pattern" }
}
if ($fail.Count -gt 0) { $fail | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Output "Project document quality gate: PASS ($($files.Count) files)"
