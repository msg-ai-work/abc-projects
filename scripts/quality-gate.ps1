param(
  [string]$ProjectId = '',
  [string]$Root = ''
)

$ErrorActionPreference = 'Stop'
$rootPath = if ($Root) { $Root } elseif ($ProjectId) { "docs/projects/$ProjectId" } else { 'docs/projects' }

if (-not (Test-Path $rootPath)) {
  Write-Output "Quality gate: no project artifact directory yet ($rootPath)"
  exit 0
}

$files = @(Get-ChildItem $rootPath -Filter '*.md' -Recurse -ErrorAction SilentlyContinue)
$script:fail = New-Object System.Collections.Generic.List[object]

function Add-Failure([string]$Code, [string]$File, [string]$Message) {
  $script:fail.Add([pscustomobject]@{
    Code = $Code
    File = $File
    Message = $Message
  }) | Out-Null
}

$contentByName = @{}
foreach ($f in $files) {
  $text = Get-Content $f.FullName -Raw
  $contentByName[$f.Name] = $text

  if ($text -match '(?i)(<YOUR_TOKEN>|ghp_[A-Za-z0-9]{20,}|AKIA[0-9A-Z]{16}|Bearer\s+[A-Za-z0-9._-]{20,})') {
    Add-Failure 'SECURITY' $f.Name 'possible credential pattern'
  }

  if ($text -match '(?im)^\s*[-*]?\s*Status\s*:\s*Approved\s*$' -and $text -notmatch '(?im)^#{1,6}\s+Evidence\b|^\s*[-*]?\s*Evidence\s*:') {
    Add-Failure 'EVIDENCE' $f.Name 'Approved without Evidence'
  }
}

$intake = $contentByName['01-PROJECT-INTAKE.md']
if ($intake) {
  foreach ($check in @(
    @{ Pattern = '(?i)\bGoal\b|목표'; Message = 'Goal missing' },
    @{ Pattern = '(?i)In Scope|포함 범위'; Message = 'In Scope missing' },
    @{ Pattern = '(?i)Out of Scope|제외 범위'; Message = 'Out of Scope missing' },
    @{ Pattern = '(?i)Stakeholder|R&R|이해관계자'; Message = 'Stakeholder/R&R missing' },
    @{ Pattern = '(?i)Success Criteria|성공 기준'; Message = 'Success Criteria missing' },
    @{ Pattern = '(?i)Open Decision|미결정'; Message = 'Open Decision section missing' }
  )) {
    if ($intake -notmatch $check.Pattern) {
      Add-Failure 'SCOPE' '01-PROJECT-INTAKE.md' $check.Message
    }
  }
}

$requirement = $contentByName['02-REQUIREMENT.md']
if ($requirement) {
  if ($requirement -notmatch '(?i)\bREQ[-_ ]?\d+\b') {
    Add-Failure 'REQUIREMENT' '02-REQUIREMENT.md' 'requirement ID missing'
  }
  if ($requirement -notmatch '(?i)Acceptance Criteria|Given\s+.+When\s+.+Then') {
    Add-Failure 'REQUIREMENT' '02-REQUIREMENT.md' 'Acceptance Criteria missing'
  }
}

$architectureParts = @()
foreach ($name in @('03-IMPACT-ANALYSIS.md', '03-INTERFACE-DESIGN.md')) {
  if ($contentByName.ContainsKey($name)) { $architectureParts += $contentByName[$name] }
}
if ($architectureParts.Count -gt 0) {
  $architecture = $architectureParts -join "`n"
  foreach ($keyword in @('Timeout', 'Retry', 'Idempotency')) {
    if ($architecture -notmatch "(?i)\b$keyword\b") {
      Add-Failure 'ARCHITECTURE' '03-*' "$keyword contract missing"
    }
  }
}

$delivery = $contentByName['04-DELIVERY-PLAN.md']
if ($delivery) {
  if ($delivery -notmatch '(?i)Dependency|의존') {
    Add-Failure 'DELIVERY' '04-DELIVERY-PLAN.md' 'Dependency missing'
  }
  if ($delivery -notmatch '(?i)담당자|Owner') {
    Add-Failure 'DELIVERY' '04-DELIVERY-PLAN.md' 'responsible assignee missing'
  }
  if ($delivery -notmatch '(?i)Due Date|기한|완료일') {
    Add-Failure 'DELIVERY' '04-DELIVERY-PLAN.md' 'Due Date missing'
  }
}

$testReadiness = $contentByName['05-TEST-READINESS.md']
if ($testReadiness) {
  foreach ($check in @(
    @{ Pattern = '(?i)Traceability|추적성'; Message = 'Requirement-to-Test Traceability missing' },
    @{ Pattern = '(?i)Environment|환경'; Message = 'test environment evidence missing' },
    @{ Pattern = '(?i)Threshold|임계'; Message = 'performance/readiness Threshold missing' },
    @{ Pattern = '(?i)Evidence|증적'; Message = 'test Evidence missing' }
  )) {
    if ($testReadiness -notmatch $check.Pattern) {
      Add-Failure 'TEST' '05-TEST-READINESS.md' $check.Message
    }
  }
  if ($testReadiness -match '(?im)^\s*[-*]?\s*Critical Defect\s*:\s*([1-9]\d*)\s*$') {
    Add-Failure 'TEST' '05-TEST-READINESS.md' 'Critical Defect must be 0'
  }
}

$cutover = $contentByName['06-CUTOVER-PLAN.md']
if ($cutover) {
  if ($cutover -notmatch '(?i)Go/No-Go|Go-No-Go|Go No-Go') {
    Add-Failure 'CUTOVER' '06-CUTOVER-PLAN.md' 'Go/No-Go criteria missing'
  }
  if ($cutover -notmatch '(?i)Monitoring|모니터링') {
    Add-Failure 'CUTOVER' '06-CUTOVER-PLAN.md' 'Monitoring plan missing'
  }
  if ($cutover -notmatch '(?i)Rollback Trigger|Rollback Criteria|원복 기준|원복 조건') {
    Add-Failure 'CUTOVER' '06-CUTOVER-PLAN.md' 'Rollback trigger missing'
  }
}

$handover = $contentByName['07-HANDOVER.md']
if ($handover) {
  foreach ($check in @(
    @{ Pattern = '(?i)Runbook|운영 절차'; Message = 'Runbook missing' },
    @{ Pattern = '(?i)Alert|Incident|Alarm|장애'; Message = 'Alert/Incident response missing' },
    @{ Pattern = '(?i)Account|Permission|권한'; Message = 'Account/Permission handover missing' },
    @{ Pattern = '(?i)Known Issue|Known Issues|알려진 이슈'; Message = 'Known Issues missing' },
    @{ Pattern = '(?i)Training|Contact|교육|연락'; Message = 'Training/Contact missing' },
    @{ Pattern = '(?i)Support Scope|지원 범위'; Message = 'Support Scope missing' },
    @{ Pattern = '(?i)Human Acceptance|운영 인수'; Message = 'Human Acceptance section missing' }
  )) {
    if ($handover -notmatch $check.Pattern) {
      Add-Failure 'HANDOVER' '07-HANDOVER.md' $check.Message
    }
  }
}

$riskRegister = $contentByName['04-RISK-REGISTER.md']
if ($riskRegister -and $riskRegister -match '(?i)\bAccepted\b' -and $riskRegister -notmatch '(?i)Human Approval Evidence|승인 Evidence|승인 근거') {
  Add-Failure 'RISK' '04-RISK-REGISTER.md' 'Risk Accepted without human approval evidence'
}

if ($script:fail.Count -gt 0) {
  foreach ($item in $script:fail) {
    Write-Error "[$($item.Code)] $($item.File): $($item.Message)"
  }
  exit 1
}

Write-Output "Project quality gate: PASS ($($files.Count) files, root=$rootPath)"
