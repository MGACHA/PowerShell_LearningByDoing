# Define source
$sourcePath = "C:\Temp\PowerShell"

# Define destination path
$destinationPath = "C:\Temp\PowerShell\Destination"

# Find files like 2024_Sep, 2025_Jan, etc. contains an underscore anywhere in the name "*_*".
$files = Get-ChildItem $sourcePath | Where-Object { $_.Name -like "*_*" }

foreach ($file in $files) {
    # Get the year (example: 2024 from "2024_Sep")
    # Get the FIRST item from the array (arrays start counting at 0)
    $year = $file.BaseName.Split("_")[0]
    
    # Get the full name without extension (example: 2024_Sep)
    $folderName = $file.BaseName
    
    # Create folders
    $yearFolder = "$destinationPath\$year"
    $newFolder = "$yearFolder\$folderName"
    
    New-Item -Path $newFolder -ItemType Directory -Force | Out-Null
    
    # Copy file
    Copy-Item $file.FullName -Destination "$newFolder\$($file.Name)"
    
    Write-Host "Copied $($file.Name) to $year\$folderName"
}

Write-Host "Operation completed!" -ForegroundColor Magenta
