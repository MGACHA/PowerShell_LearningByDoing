Import-Module ImportExcel

# Folder containing XLSX files
$folderPath = "C:\Temp\PowerShell\test_folder1"

# Convert all XLSX files in folder
Get-ChildItem -Path $folderPath -Filter *.xlsx -File | ForEach-Object {
    $xlsxFile = $_.FullName
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($xlsxFile)

    Write-Host "Processing: $($_.Name)" -ForegroundColor Cyan

    try {
        # Get all sheet names from workbook
        $sheets = Get-ExcelSheetInfo -Path $xlsxFile

        foreach ($sheet in $sheets) {
            # Make sheet name safe for file names
            $safeSheetName = ($sheet.Name -replace '[\\/:*?"<>|]', '_')
            $csvFile = Join-Path $folderPath "$baseName-$safeSheetName.csv"

            # Read sheet and export to CSV
            Import-Excel -Path $xlsxFile -WorksheetName $sheet.Name |
                Export-Csv -Path $csvFile -NoTypeInformation -Encoding UTF8

            Write-Host "  Created: $([System.IO.Path]::GetFileName($csvFile))" -ForegroundColor Green
        }
    }
    catch {
        Write-Host "  Error: $_" -ForegroundColor Red
    }
}

Write-Host "Complete!" -ForegroundColor Green
