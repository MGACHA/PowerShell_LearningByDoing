#set-location "C:\Temp\PowerShell\testfolder\photos"

# PowerShell script to rename JPEG files based on their "Date Taken" EXIF metadata

# location of the .jpg files
$path = "C:\Temp\PowerShell\testfolder\photos"

# Load System.Drawing assembly to read EXIF metadata. Open images and read EXIF metadata (like Date taken).
[reflection.assembly]::LoadWithPartialName("System.Drawing") | Out-Null

# Find all .jpg files in the path and process each one
Get-ChildItem $path -Filter *.jpg | ForEach-Object {
    try {
        # Opens the image in memory and reads metadata
        $pic = New-Object System.Drawing.Bitmap($_.FullName)
        # Read the "Date Taken". "36867" = DateTimeOriginal
        $bytearr = $pic.GetPropertyItem(36867).Value
        # Convert byte array to string 
        $string = [System.Text.Encoding]::ASCII.GetString($bytearr)
        # Convert the date taken into a DateTime object "yyyy:MM:dd HH:mm:ss`0"
        $dateTime = [datetime]::ParseExact($string, "yyyy:MM:dd HH:mm:ss`0", $Null)
        # Release the file and free the memory now.
        $pic.Dispose()
        
        # Create new file name based on date taken
        $newName = "Photo_{0:yyyyMMdd_HHmmss}{1}" -f $dateTime, $_.Extension
        
        # Check if file with new name already exists - check for duplicates. Add suffix _01, _02, etc.
        $counter = 1
        $finalName = $newName
        while (Test-Path (Join-Path $path $finalName)) {
            $baseName = "Photo_{0:yyyyMMdd_HHmmss}_{1:D2}" -f $dateTime, $counter
            $finalName = "$baseName$($_.Extension)"
            $counter++
        }
        # Rename the file
        Rename-Item $_.FullName -NewName $finalName
        Write-Host "Renamed: $($_.Name) -> $finalName" -ForegroundColor Green
    }
    catch {
        Write-Host "No date taken found for: $($_.Name)" -ForegroundColor Red
    }
}
