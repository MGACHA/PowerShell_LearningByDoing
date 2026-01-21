# Create a new folder named "Year"

New-Item Year -ItemType Directory

# Set location of the new folder

Set-Location C:\Temp\PowerShell\Year


# Define the years
$years = @(2024, 2025, 2026)

# Create year folders and month subfolders
foreach ($year in $years) {
    # Create the year folder
    New-Item -Path ".\$year" -ItemType Directory 

    # Create month subfolders (1-12)
    for ($month = 01; $month -le 12; $month++) {
        New-Item -Path ".\$year\$month" -ItemType Directory
    }
}

 # Writes customized output to a host.

Write-Host "Folders created successfully!" -ForegroundColor Green
