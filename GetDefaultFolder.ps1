# Script to find and save attachments with specific text in filename

# Creates a live connection to Outlook (desktop app) MAPI = Outlook’s messaging system
try {
    $outlook = New-Object -ComObject Outlook.Application
    $namespace = $outlook.GetNamespace("MAPI")
    
    # Define destination folder and search pattern
    $destinationFolder = "C:\Temp\PowerShell\testfolder\Outlook_attachments"
    $searchPattern = "jpg"  # Change this to search for different attachment text
    $cutoffDate = (Get-Date).AddDays(-7)  # last 7 days

    # Get default inbox folder
    # find here: https://learn.microsoft.com/en-us/dotnet/api/microsoft.office.interop.outlook.oldefaultfolders?view=outlook-pia
    $inbox = $namespace.GetDefaultFolder(6)  # 6 = olFolderInbox
    
    # Informational output and formatting
    Write-Verbose "Date filter will search from: $($cutoffDate.ToString('yyyy-MM-dd'))"
    
    # Use for a final summary at the end.
    $attachmentCount = 0
    
    function Save-AttachmentsInFolder { 
        param([object]$folder)
        
        Write-Host "Searching in folder: $($folder.Name)" -ForegroundColor Yellow
        
        # Search through all items in the folder
        foreach ($item in $folder.Items) {
            # Filter by date - only process emails from last 7 days
            if ($item.ReceivedTime -ge $cutoffDate) {
                if ($item.Attachments.Count -gt 0) {
                foreach ($attachment in $item.Attachments) {
                    $fileName = $attachment.FileName
                   
                    # Check if filename contains the search pattern (case-insensitive)
                    if ($fileName -like "*$searchPattern*") {
                        try {
                            $savePath = Join-Path $destinationFolder $fileName
                            
                            # Handle duplicate filenames
                            $counter = 1
                            while (Test-Path $savePath) {
                                $fileNameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($fileName)
                                $extension = [System.IO.Path]::GetExtension($fileName)
                                $savePath = Join-Path $destinationFolder "$fileNameWithoutExt`_$counter$extension"
                                $counter++
                            }
                            # Pulls the attachment and writes it to disk
                            $attachment.SaveAsFile($savePath)
                            Write-Host "  Saved: $fileName to $savePath" -ForegroundColor Green
                            Write-Host "    From: $($item.SenderName); Subject: $($item.Subject); 
                                            Date: $($item.ReceivedTime.ToString('yyyy-MM-dd'))" -ForegroundColor Cyan
                            
                            $script:attachmentCount++
                        }
                        catch {
                            Write-Host "  Failed to save: $fileName - $($_.Exception.Message)" -ForegroundColor Red
                        }
                    }
                }
            }
            }
        }
        
        # Search in subfolders recursively
        foreach ($subfolder in $folder.Folders) {
            Save-AttachmentsInFolder -folder $subfolder
        }
    }
    
    Write-Host "Starting search for attachments containing: '$searchPattern'" -ForegroundColor Green
    Write-Host "Date filter: Last 7 days (from $($cutoffDate.ToString('yyyy-MM-dd')) to today)" -ForegroundColor Magenta
    Write-Host "Destination: $destinationFolder`n" -ForegroundColor Green
    
    Save-AttachmentsInFolder -folder $inbox
    
    Write-Host "`nTotal attachments saved: $attachmentCount" -ForegroundColor Green
    
}
catch {
    Write-Error "Error accessing Outlook: $_"
}

# Releases the Outlook COM object from memory
finally {
    if ($outlook) {
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($outlook) | Out-Null
    }
}
