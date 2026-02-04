# PowerShell script to create 10 test files with random LastWriteTime between 2016 and 2026
set-location -Path "C:\Temp\PowerShell\testfolder"
$basePath = "C:\Temp\PowerShell\testfolder"
New-Item -Path $basePath -ItemType Directory -Force | Out-Null

for ($i = 1; $i -le 10; $i++) {
    # Create a new file with some content
    #$fileName = "document_$i.pdf" 
    $fileName = "photo_$i.jpg"
    $filePath = Join-Path $basePath $fileName
    "This is test file $i" | Out-File $filePath -Encoding utf8
    
    # Generate random year between 2016 and 2026
    $year = Get-Random -Minimum 2016 -Maximum 2027
    # Random month (1-12)
    $month = Get-Random -Minimum 1 -Maximum 13
    # Random day (1-28 to avoid month-end issues)
    $day = Get-Random -Minimum 1 -Maximum 29
    # Random hour and minute
    $hour = Get-Random -Minimum 0 -Maximum 24
    $minute = Get-Random -Minimum 0 -Maximum 60
    
    # Create the date and set LastWriteTime
    $date = Get-Date -Year $year -Month $month -Day $day -Hour $hour -Minute $minute -Second 0
    (Get-Item $filePath).LastWriteTime = $date
    
    Write-Host "Created $fileName with LastWriteTime: $($date.ToString('yyyy-MM-dd HH:mm'))"
}

Write-Host "All 10 files created in $basePath. Use Get-ChildItem $basePath | Select Name, LastWriteTime to verify."

