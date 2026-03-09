# PowerShell script to export Outlook emails to CSV
Set-Location -Path "C:\Temp\PowerShell\test_folder1"
# Create Outlook COM object
$outlook = New-Object -ComObject Outlook.Application
$namespace = $outlook.GetNamespace("MAPI")
$inbox = $namespace.GetDefaultFolder(6)  # 6 = olFolderInbox

# Calculate date 30 days ago
$cutoffDate = (Get-Date).AddDays(-30)

# Initialize array to store email data
$emails = @()

# Function to recursively process folders
function Process-Folder {
    param(
        $Folder,
        $CutoffDate
    )    
    # Process emails in current folder
    foreach ($mail in $Folder.Items) {
        if ($mail.ReceivedTime -ge $CutoffDate) {
            $script:emails += [PSCustomObject]@{
                From    = $mail.SenderName                
                Date    = $mail.ReceivedTime
                Subject = $mail.Subject
                Folder  = $Folder.Name
            }
        }
    }    
    # Process subfolders recursively
    foreach ($subFolder in $Folder.Folders) {
        Process-Folder -Folder $subFolder -CutoffDate $CutoffDate
    }
}
# Process inbox and all subfolders
Process-Folder -Folder $inbox -CutoffDate $cutoffDate

# Generate filename with today's date
$todayDate = Get-Date -Format "yyyy-MM-dd"
$outputFile = "$outputFolder\OutlookExport_$todayDate.csv"

# Export to CSV
$emails | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

Write-Host "Emails from last 30 days exported successfully to $outputFile"