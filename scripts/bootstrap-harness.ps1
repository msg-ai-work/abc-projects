param([string]$Ref = "")
$ErrorActionPreference = "Stop"
$Repo = "https://github.com/msg-ai-work/abc.git"
$Dest = ".ai-harness/common"
if ([string]::IsNullOrWhiteSpace($Ref)) {
  $match = Select-String -Path "harness.yaml" -Pattern '^\s*ref:\s*(.+)\s*$' | Select-Object -First 1
  if ($match) { $Ref = $match.Matches[0].Groups[1].Value.Trim() }
  if ([string]::IsNullOrWhiteSpace($Ref)) { $Ref = "main" }
}
New-Item -ItemType Directory -Force -Path ".ai-harness" | Out-Null
if (Test-Path "$Dest/.git") { git -C $Dest fetch --tags origin } else { git clone $Repo $Dest }
if ($LASTEXITCODE -ne 0) { throw "Common Harness clone/fetch failed. GitHub authentication을 확인하세요." }
git -C $Dest fetch --tags origin
if ($Ref -eq "main") { git -C $Dest checkout main; git -C $Dest pull --ff-only origin main } else { git -C $Dest checkout --detach $Ref }
if ($LASTEXITCODE -ne 0) { throw "Common Harness ref '$Ref' checkout failed." }
$required = @("$Dest/HARNESS.md", "$Dest/.kiro/steering", "$Dest/.kiro/skills", ".kiro/agents/enterprise-messaging-projects.json")
foreach ($path in $required) { if (-not (Test-Path $path)) { throw "Required Harness resource missing: $path" } }
Write-Host "Common Harness ready: $Repo @ $Ref"
Write-Host "Kiro Agent: enterprise-messaging-projects"
