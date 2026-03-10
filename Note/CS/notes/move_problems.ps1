# Move Algorithm Problems Script
# Move all algorithm problem files to the solution folder

$notesPath = "d:\Learn\Note\CS\notes"
$targetPath = "$notesPath\算法与数据结构\题解区"

Set-Location $notesPath

# Create target folder if not exists
if (-not (Test-Path $targetPath)) {
    New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
    Write-Host "Created folder: $targetPath"
}

$movedCount = 0
$skippedCount = 0

Write-Host "`nMoving algorithm problem files..."
Write-Host "=" * 60

# Move files starting with numbers (e.g., 3.md, 10.1.md, 18.2.md)
Write-Host "`n[1] Moving numbered problem files..."
Get-ChildItem -Path $notesPath -File "*.md" | Where-Object { 
    $_.Name -match "^\d+(\.\d+)*\s*.+\.md$" 
} | ForEach-Object {
    try {
        $destFile = Join-Path $targetPath $_.Name
        if (Test-Path $destFile) {
            Write-Host "  Skip (exists): $($_.Name)"
            $skippedCount++
        } else {
            Move-Item $_.FullName $targetPath -Force
            Write-Host "  Moved: $($_.Name)"
            $movedCount++
        }
    } catch {
        Write-Host "  Error: $($_.Name)"
    }
}

# Move Leetcode files
Write-Host "`n[2] Moving Leetcode files..."
Get-ChildItem -Path $notesPath -File "Leetcode*.md" | ForEach-Object {
    try {
        $destFile = Join-Path $targetPath $_.Name
        if (Test-Path $destFile) {
            Write-Host "  Skip (exists): $($_.Name)"
            $skippedCount++
        } else {
            Move-Item $_.FullName $targetPath -Force
            Write-Host "  Moved: $($_.Name)"
            $movedCount++
        }
    } catch {
        Write-Host "  Error: $($_.Name)"
    }
}

# Move Jianzhioffer files
Write-Host "`n[3] Moving Jianzhioffer files..."
Get-ChildItem -Path $notesPath -File "*剑指*.md" | ForEach-Object {
    try {
        $destFile = Join-Path $targetPath $_.Name
        if (Test-Path $destFile) {
            Write-Host "  Skip (exists): $($_.Name)"
            $skippedCount++
        } else {
            Move-Item $_.FullName $targetPath -Force
            Write-Host "  Moved: $($_.Name)"
            $movedCount++
        }
    } catch {
        Write-Host "  Error: $($_.Name)"
    }
}

Write-Host "`n" + ("=" * 60)
Write-Host "`nSummary:"
Write-Host "  Moved: $movedCount files"
Write-Host "  Skipped: $skippedCount files"

$totalFiles = (Get-ChildItem -Path $targetPath -File | Measure-Object).Count
Write-Host "`nTotal files in solution folder: $totalFiles"
Write-Host "`nDone!"
