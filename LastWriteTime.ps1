# Folder containing unsorted files to process
$source = "C:\Temp\PowerShell\testfolder3"
# Destination folder where organized Year\Year_Month folders will be created
$destination = "C:\Temp\PowerShell\testfolder3\Destination"

# Get all files (not folders) from source and process each one
Get-ChildItem $source -File | ForEach-Object {
# Extract year/month from the file's LastWriteTime (Date Modified)
$year = $_.LastWriteTime.Year
$month = '{0:00}' -f $_.LastWriteTime.Month

 # Build year folder path under target destination
$yearFolder = Join-Path $destination $year
$monthFolder = Join-Path $yearFolder "${year}_${month}"

# Create the month folder if it doesn't exist
New-Item $monthFolder -ItemType Directory -Force | Out-Null

# Move the file into the appropriate month folder
Move-Item $_.FullName -Destination $monthFolder
}
Write-Host "Files sorted by LastWriteTime into $destination"
