# 自動在 GitHub 建立公開儲存庫並 push（需 Personal Access Token）
# 使用方式：在專案資料夾開 PowerShell，執行  .\create-github-push.ps1
# Token 建立：https://github.com/settings/tokens  → Generate new token (classic)
#           勾選權限：repo（完整 repository 權限）

$ErrorActionPreference = "Stop"
$git = "C:\Program Files\Git\bin\git.exe"
if (-not (Test-Path $git)) { $git = "git" }

Set-Location $PSScriptRoot

Write-Host "`n=== GitHub：建立儲存庫並推送 ===`n" -ForegroundColor Cyan
Write-Host "需 Classic PAT，權限勾選 repo。`n" -ForegroundColor Yellow

$user = Read-Host "GitHub 使用者名稱 (username)"
$repo = Read-Host "新儲存庫名稱 (建議英數，例如 pure-css-financial-dashboard)"
if ([string]::IsNullOrWhiteSpace($repo)) { $repo = "pure-css-financial-dashboard" }

$sec = Read-Host "Personal Access Token" -AsSecureString
$ptr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($sec)
try { $token = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($ptr) }
finally { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr) }

$headers = @{
  Authorization = "Bearer $token"
  Accept        = "application/vnd.github+json"
  "User-Agent"  = "pure-css-dashboard-setup"
}

$body = @{ name = $repo; private = $false; auto_init = $false } | ConvertTo-Json

try {
  Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Method Post -Headers $headers -Body $body -ContentType "application/json"
  Write-Host "`n已建立：https://github.com/$user/$repo`n" -ForegroundColor Green
}
catch {
  if ($_.Exception.Response.StatusCode -eq 422) {
    Write-Host "`n儲存庫可能已存在，將直接設定 remote 並嘗試 push...`n" -ForegroundColor Yellow
  }
  else {
    Write-Host "`n建立失敗：$($_.Exception.Message)" -ForegroundColor Red
    if ($_.ErrorDetails.Message) { Write-Host $_.ErrorDetails.Message }
    Read-Host "`n按 Enter 關閉"
    exit 1
  }
}

$remoteUrl = "https://github.com/$user/$repo.git"
& $git remote remove origin 2>$null
& $git remote add origin $remoteUrl

# 使用 token 推送（僅本機處理序；推送後請勿分享螢幕錄影）
$pushUrl = "https://${user}:${token}@github.com/${user}/${repo}.git"
& $git push -u $pushUrl main
if ($LASTEXITCODE -ne 0) {
  Write-Host "`npush 失敗。可改用手動：git push -u origin main（會跳出登入視窗）" -ForegroundColor Red
  Read-Host "`n按 Enter 關閉"
  exit $LASTEXITCODE
}

& $git remote set-url origin $remoteUrl
Write-Host "`n完成。遠端已改回不含 Token 的網址，之後請用 Git 憑證管理員登入。`n" -ForegroundColor Green
Write-Host "網址：https://github.com/$user/$repo`n"
Read-Host "按 Enter 關閉"
