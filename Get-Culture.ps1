# Current directory;
$Location = "C:\Temp\PowerShell\"  

# Years
$years = 2024#, 2025

# Abbreviated month names
$months = (Get-Culture).DateTimeFormat.AbbreviatedMonthNames[0..11]

foreach ($year in $years) {
    foreach ($monthIndex in 0..11) {
        $fileName = "${year}_$monthName"
        $monthName = $months[$monthIndex]
        

        # CSV file
        $csvPath = Join-Path $Location "$fileName.csv"
        "ID,Date,Description,Amount" | Out-File -FilePath $csvPath -Encoding UTF8      
             }
}

Write-Host "All CSV files created!" -ForegroundColor Cyan
