# 在「已安裝 Git」的電腦上，於本專案資料夾以 PowerShell 執行：
#   .\push-to-github.ps1
# 若執行原則擋住，先執行： Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "找不到 Git。請安裝：https://git-scm.com/download/win  安裝後重開終端機再執行本腳本。" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path .git)) {
    git init
    Write-Host "已 git init" -ForegroundColor Green
}

git add .
$hasCommit = git rev-parse HEAD 2>$null
if (-not $hasCommit) {
    git commit -m "feat: pure CSS financial terminal dashboard"
    Write-Host "已建立首次 commit" -ForegroundColor Green
} else {
    $dirty = git status --porcelain
    if ($dirty) {
        git commit -am "chore: update project files"
        Write-Host "已提交變更" -ForegroundColor Green
    } else {
        Write-Host "沒有新的變更可提交" -ForegroundColor Yellow
    }
}

git branch -M main 2>$null

$origin = ""
try { $origin = git remote get-url origin 2>$null } catch {}
if ([string]::IsNullOrWhiteSpace($origin)) {
    Write-Host ""
    Write-Host "請先到 https://github.com/new 建立空儲存庫（不要勾 README）。" -ForegroundColor Cyan
    $url = Read-Host "貼上儲存庫 HTTPS 網址 (例 https://github.com/帳號/專案名.git)"
    if ([string]::IsNullOrWhiteSpace($url)) {
        Write-Host "未設定 remote，結束。" -ForegroundColor Red
        exit 1
    }
    git remote add origin $url.Trim()
}

Write-Host "正在 push 到 origin main ..." -ForegroundColor Cyan
git push -u origin main
if ($LASTEXITCODE -eq 0) {
    Write-Host "完成。" -ForegroundColor Green
} else {
    Write-Host "push 失敗。請確認已登入 GitHub（瀏覽器或 Personal Access Token）。" -ForegroundColor Red
    exit $LASTEXITCODE
}
