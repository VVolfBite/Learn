# 算法题移动脚本
# 功能：将根目录下的所有算法题解文件移动到 算法与数据结构/题解区/ 文件夹

# 设置工作目录
$notesPath = "d:\Learn\Note\CS\notes"
$targetPath = "$notesPath\算法与数据结构\题解区"

# 切换到notes目录
Set-Location $notesPath

# 确保目标文件夹存在
if (-not (Test-Path $targetPath)) {
    New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
    Write-Host "已创建题解区文件夹: $targetPath" -ForegroundColor Green
}

# 统计变量
$movedCount = 0
$skippedCount = 0
$errorCount = 0

Write-Host "`n开始移动算法题解文件..." -ForegroundColor Cyan
Write-Host "=" * 60

# 1. 移动数字开头的题解文件（如 3.md, 10.1.md, 18.2.md 等）
Write-Host "`n[1] 移动数字开头的题解文件..." -ForegroundColor Yellow
Get-ChildItem -Path $notesPath -File "*.md" | Where-Object { 
    $_.Name -match "^\d+(\.\d+)*\s*.+\.md$" 
} | ForEach-Object {
    try {
        $destFile = Join-Path $targetPath $_.Name
        if (Test-Path $destFile) {
            Write-Host "  跳过（已存在）: $($_.Name)" -ForegroundColor Gray
            $skippedCount++
        } else {
            Move-Item $_.FullName $targetPath -Force
            Write-Host "  ✓ 已移动: $($_.Name)" -ForegroundColor Green
            $movedCount++
        }
    } catch {
        Write-Host "  ✗ 错误: $($_.Name) - $($_.Exception.Message)" -ForegroundColor Red
        $errorCount++
    }
}

# 2. 移动Leetcode题解文件
Write-Host "`n[2] 移动Leetcode题解文件..." -ForegroundColor Yellow
Get-ChildItem -Path $notesPath -File "Leetcode*.md" | ForEach-Object {
    try {
        $destFile = Join-Path $targetPath $_.Name
        if (Test-Path $destFile) {
            Write-Host "  跳过（已存在）: $($_.Name)" -ForegroundColor Gray
            $skippedCount++
        } else {
            Move-Item $_.FullName $targetPath -Force
            Write-Host "  ✓ 已移动: $($_.Name)" -ForegroundColor Green
            $movedCount++
        }
    } catch {
        Write-Host "  ✗ 错误: $($_.Name) - $($_.Exception.Message)" -ForegroundColor Red
        $errorCount++
    }
}

# 3. 移动剑指Offer题解文件
Write-Host "`n[3] 移动剑指Offer题解文件..." -ForegroundColor Yellow
Get-ChildItem -Path $notesPath -File "*剑指*.md" | ForEach-Object {
    try {
        $destFile = Join-Path $targetPath $_.Name
        if (Test-Path $destFile) {
            Write-Host "  跳过（已存在）: $($_.Name)" -ForegroundColor Gray
            $skippedCount++
        } else {
            Move-Item $_.FullName $targetPath -Force
            Write-Host "  ✓ 已移动: $($_.Name)" -ForegroundColor Green
            $movedCount++
        }
    } catch {
        Write-Host "  ✗ 错误: $($_.Name) - $($_.Exception.Message)" -ForegroundColor Red
        $errorCount++
    }
}

# 4. 移动其他可能的算法题文件（可选，根据需要调整）
Write-Host "`n[4] 检查其他可能的算法题文件..." -ForegroundColor Yellow
$algorithmKeywords = @("算法", "题解", "刷题")
Get-ChildItem -Path $notesPath -File "*.md" | Where-Object {
    $name = $_.Name
    $algorithmKeywords | Where-Object { $name -like "*$_*" }
} | ForEach-Object {
    # 排除模块文件
    if ($_.Name -notlike "*算法与数据结构*" -and $_.Name -notlike "*目录*") {
        try {
            $destFile = Join-Path $targetPath $_.Name
            if (Test-Path $destFile) {
                Write-Host "  跳过（已存在）: $($_.Name)" -ForegroundColor Gray
                $skippedCount++
            } else {
                Write-Host "  发现可能的算法题: $($_.Name)" -ForegroundColor Cyan
                $response = Read-Host "  是否移动？(Y/N)"
                if ($response -eq 'Y' -or $response -eq 'y') {
                    Move-Item $_.FullName $targetPath -Force
                    Write-Host "  ✓ 已移动: $($_.Name)" -ForegroundColor Green
                    $movedCount++
                } else {
                    Write-Host "  跳过: $($_.Name)" -ForegroundColor Gray
                    $skippedCount++
                }
            }
        } catch {
            Write-Host "  ✗ 错误: $($_.Name) - $($_.Exception.Message)" -ForegroundColor Red
            $errorCount++
        }
    }
}

# 输出统计结果
Write-Host "`n" + ("=" * 60) -ForegroundColor Cyan
Write-Host "`n移动完成！统计结果：" -ForegroundColor Cyan
Write-Host "  ✓ 成功移动: $movedCount 个文件" -ForegroundColor Green
Write-Host "  - 跳过: $skippedCount 个文件（已存在）" -ForegroundColor Gray
if ($errorCount -gt 0) {
    Write-Host "  ✗ 错误: $errorCount 个文件" -ForegroundColor Red
}

# 显示题解区文件统计
$totalFiles = (Get-ChildItem -Path $targetPath -File | Measure-Object).Count
Write-Host "`n题解区当前共有: $totalFiles 个文件" -ForegroundColor Cyan

Write-Host "`n脚本执行完成！" -ForegroundColor Green
