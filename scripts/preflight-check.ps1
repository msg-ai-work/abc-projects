$ErrorActionPreference = 'Stop'
$fail = @()
$required = @('project-config.md','DOMAIN.md','harness.yaml','.kiro/agents/project-orchestrator.json','workflows/project-delivery.md','skills/project-intake-scope/SKILL.md','skills/requirement-analysis/SKILL.md','skills/architecture-impact/SKILL.md','skills/test-readiness/SKILL.md','skills/cutover-plan/SKILL.md','skills/rollback-plan/SKILL.md')
foreach ($p in $required) { if (-not (Test-Path $p)) { $fail += "missing: $p" } }
if (-not (Test-Path '.ai-harness/common/HARNESS.md')) { Write-Warning 'Common Harness is not mounted at .ai-harness/common. Run bootstrap before full Forge execution.' }
if (Select-String -Path 'project-config.md' -Pattern '<project-owner>|<KEY>|<SPACE>' -Quiet) { Write-Warning 'project-config.md still contains sample placeholders.' }
if ($fail.Count -gt 0) { $fail | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Output 'ABC Project Forge preflight: PASS'
