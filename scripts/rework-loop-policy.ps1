param(
  [Parameter(Mandatory=$true)][ValidateSet('SCOPE','REQUIREMENT','ARCHITECTURE','DELIVERY','TEST','CUTOVER','HANDOVER')][string]$GateCode,
  [Parameter(Mandatory=$true)][ValidateRange(1,999)][int]$FailureCount,
  [ValidateRange(1,99)][int]$MaxReworks = 3,
  [switch]$AsJson
)

$ErrorActionPreference = 'Stop'
$agentMap = @{
  SCOPE = '01-project-intake'
  REQUIREMENT = '02-requirement'
  ARCHITECTURE = '03-architecture'
  DELIVERY = '04-delivery-plan'
  TEST = '05-test-readiness'
  CUTOVER = '06-cutover'
  HANDOVER = '07-handover'
}

$decision = if ($FailureCount -le $MaxReworks) { 'REWORK' } else { 'ESCALATE' }
$result = [pscustomobject]@{
  gate_code = $GateCode
  rework_agent = if ($decision -eq 'REWORK') { $agentMap[$GateCode] } else { $null }
  failure_count = $FailureCount
  max_reworks = $MaxReworks
  decision = $decision
  fail_code = if ($decision -eq 'ESCALATE') { 'REWORK_LIMIT' } else { $GateCode }
  next_human_action = if ($decision -eq 'ESCALATE') { 'Review repeated failure evidence and decide scope/design/risk disposition.' } else { $null }
}

if ($AsJson) {
  $result | ConvertTo-Json -Compress
} else {
  $result
}
