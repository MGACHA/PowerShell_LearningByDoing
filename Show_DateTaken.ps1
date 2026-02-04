# PowerShell script to show the "Date Taken" EXIF metadata of JPG files
$path = "C:\Temp\PowerShell\testfolder\photos"

# Load System.Drawing assembly to read EXIF metadata data
[reflection.assembly]::LoadWithPartialName("System.Drawing") | Out-Null

# Find all .jpg files in the path and process each one  
Get-ChildItem $path -Filter *.jpg | ForEach-Object {
    try {
        # Opens the image in memory and read metadata
        $pic = New-Object System.Drawing.Bitmap($_.FullName)
        # Read the "Date Taken". "36867" = DateTimeOriginal
        $bytearr = $pic.GetPropertyItem(36867).Value 
        # Convert byte array to string
        $string = [System.Text.Encoding]::ASCII.GetString($bytearr) 
        # Convert the date taken into a DateTime object "yyyy:MM:dd HH:mm:ss`0"
        $DateTime = [datetime]::ParseExact($string, "yyyy:MM:dd HH:mm:ss`0", $Null)
        # Release the file and free the memory now.
        $pic.Dispose()
        
        Write-Host "$($_.Name): $DateTime" -ForegroundColor Yellow
    }
    catch {
        Write-Host "$($_.Name): No date taken found" -ForegroundColor Red
    }
}
