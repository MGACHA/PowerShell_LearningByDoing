#Install-Module ImportExcel
#$csvPath  = "C:\Temp\PowerShell\test_folder1\OutlookExport.csv"
#$xlsxPath = "C:\Temp\PowerShell\test_folder1\OutlookExport.xls"

# single csv file
# $data = Import-Csv -Path $csvPath   # Headers: Subject, Date, From, To, Status
# $data | Export-Excel -Path $xlsxPath -WorksheetName 'OutlookExport' -AutoSize



# Import the module
Import-Module ImportExcel

# Define source folder
$folderPath = "C:\Temp\PowerShell\test_folder1"

# Get all CSV files and convert them
Get-ChildItem -Path $folderPath -Filter *.csv | ForEach-Object {
    $csvFile  = $_.FullName
    $xlsxFile = [System.IO.Path]::ChangeExtension($csvFile, ".xlsx")
    
    Write-Host "Converting: $($_.Name) -> $([System.IO.Path]::GetFileName($xlsxFile))" -ForegroundColor Cyan
    
    try {
        # Import CSV and export to Excel
        Import-Csv -Path $csvFile | Export-Excel -Path $xlsxFile -WorksheetName 'OutlookExport' -AutoSize -BoldTopRow
        
        Write-Host "  Success!" -ForegroundColor Green
    }
    catch {
        Write-Host "  Error: $_" -ForegroundColor Red
    }
}

Write-Host "Complete!" -ForegroundColor Green