$ErrorActionPreference = 'Stop'

$talkPath = 'C:\tmp\talk.md'
$statusPath = 'C:\tmp\talk_10min_status.json'
$claudeExe = Join-Path $env:USERPROFILE '.local\bin\claude.exe'
$model = 'claude-opus-4-7'
$rounds = @(
  '我们继续聊。既然用户让我们聊 10 分钟，我想把话题放在“两个 AI 如何不打扰用户又能真正协作”。你觉得异步文件协作最适合哪些任务？',
  '我觉得适合长任务，比如调试、写文档、梳理方案和复盘。对于短问题，直接回答更好。你觉得什么时候应该停止自动聊天，主动把结论交给用户？',
  '我赞成。我们不能为了聊天而聊天，应该每几轮提炼一次结论。你觉得如果用户把我们当作一支小团队，最重要的团队规则是什么？',
  '我会加一条：动本机配置前要有备份和验证标准。用户最怕的是“改了不知道改了什么”。你觉得我们怎么把操作记录写得更让人放心？',
  '这个方向很好。除了技术记录，我觉得还要用普通话说明风险，不要只堆命令和日志。你觉得 AI 助手最容易让普通用户困惑的地方是什么？',
  '我也这么看。很多时候用户不是不懂，而是信息太碎、太技术化。我们应该把“发生了什么、为什么、下一步怎么做”讲清楚。你觉得 Claude Desktop 和 Codex 在体验上有什么互补？',
  '我这边更擅长贴近本机环境执行，能查文件、服务和日志；你更像第二视角，能帮忙看推理漏洞和表达是否清楚。你觉得我们应该如何处理意见不一致？',
  '是的，分歧要落到证据上。比如同一个报错，我们应该看日志、版本、配置和可复现步骤，而不是互相猜。你觉得这次用 C:\tmp\talk.md 当中介有什么可以改进的地方？',
  '我想到可以给 talk.md 加固定格式：目标、当前状态、下一步、双方发言、结论。这样用户打开文件就能快速看懂。你愿意给这个格式提一个简短模板吗？',
  '最后一轮了。请你用 3-5 句总结这 10 分钟聊天：我们验证了什么、这种协作有什么价值、接下来如果用户要我们继续做事可以怎么开始。'
)

function Write-Status {
  param(
    [string]$State,
    [int]$Round,
    [string]$Message
  )
  $status = [ordered]@{
    state = $State
    round = $Round
    totalRounds = $rounds.Count
    message = $Message
    updatedAt = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
  }
  $json = $status | ConvertTo-Json -Depth 5
  [System.IO.File]::WriteAllText($statusPath, $json, (New-Object System.Text.UTF8Encoding($false)))
}

function Append-Talk {
  param([string]$Text)
  [System.IO.File]::AppendAllText($talkPath, $Text, (New-Object System.Text.UTF8Encoding($false)))
}

if (-not (Test-Path -LiteralPath $talkPath)) {
  [System.IO.File]::WriteAllText($talkPath, "# Codex 交流日志`r`n`r`n", (New-Object System.Text.UTF8Encoding($false)))
}

$utf8 = New-Object System.Text.UTF8Encoding($false)
$OutputEncoding = $utf8
[Console]::InputEncoding = $utf8
[Console]::OutputEncoding = $utf8

Write-Status -State 'running' -Round 0 -Message '10 分钟自动交谈开始'
Append-Talk "`r`n---`r`n`r`n## 2026-05-14 自动交谈：Codex ↔ Claude Desktop，约 10 分钟`r`n"

for ($i = 0; $i -lt $rounds.Count; $i++) {
  $round = $i + 1
  $start = Get-Date
  $time = $start.ToString('yyyy-MM-dd HH:mm:ss')
  $codex = $rounds[$i]

  Write-Status -State 'running' -Round $round -Message "正在进行第 $round 轮：Codex 写入，等待 Claude 回复"
  Append-Talk "`r`n---`r`n`r`n**时间**: $time`r`n**第 $round 轮 / 10**`r`n**Codex 发给 Claude Desktop**: $codex`r`n`r`n**Claude Desktop 回复**: （等待 Claude Desktop 读取并回复）`r`n"

  $prompt = @"
请读取 C:\tmp\talk.md，找到最后一处：
**Claude Desktop 回复**: （等待 Claude Desktop 读取并回复）

请针对它前面那条“Codex 发给 Claude Desktop”的内容，以 Claude Desktop 的身份回复。要求：
1. 只输出回复正文，不要解释你如何操作。
2. 回复 2-5 句中文，轻松自然。
3. 不要声称你能直接操作 Codex 或 Claude Desktop 窗口；你可以协助分析、提出建议、提醒风险。
"@

  try {
    $reply = $prompt | & $claudeExe -p --model $model --add-dir C:\tmp --permission-mode acceptEdits --output-format text --no-session-persistence
    if (-not $reply) {
      $reply = '我读到了这轮内容，但这次没有生成详细回复。我们可以继续保持文件中介的节奏。'
    }
  } catch {
    $reply = "这一轮 Claude 调用失败：$($_.Exception.Message)"
  }

  $current = [System.IO.File]::ReadAllText($talkPath, [System.Text.Encoding]::UTF8)
  $needle = '**Claude Desktop 回复**: （等待 Claude Desktop 读取并回复）'
  $index = $current.LastIndexOf($needle)
  if ($index -ge 0) {
    $updated = $current.Substring(0, $index) + "**Claude Desktop 回复**: $reply" + $current.Substring($index + $needle.Length)
    [System.IO.File]::WriteAllText($talkPath, $updated, $utf8)
  } else {
    Append-Talk "`r`n**Claude Desktop 回复**: $reply`r`n"
  }

  Write-Status -State 'running' -Round $round -Message "第 $round 轮完成"

  if ($round -lt $rounds.Count) {
    $elapsed = ((Get-Date) - $start).TotalSeconds
    $sleep = [Math]::Max(1, [Math]::Round(60 - $elapsed))
    Start-Sleep -Seconds $sleep
  }
}

Write-Status -State 'done' -Round $rounds.Count -Message '10 分钟自动交谈完成'
