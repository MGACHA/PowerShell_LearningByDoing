PowerShell Folder Structure Creator

YouTube chanell : https://www.youtube.com/@PowerDataHub

Published on LinkedIn

Overview

This repository contains PowerShell scripts that automate the creation of an organised folder structure.​
Perfect for data management, file organisation, or as a starting point for more advanced automation in your PowerDataHub tutorials.


**1. New-Item**

Watch this on YT https://www.youtube.com/watch?v=Ks1BMLOUijU

The script creates folders (New-Item) for each year (2024–2026) and, inside each one, it adds 12 month folders. At the end, it shows a green (colour can be different) message to confirm everything was created (Write-Host).


**2. Get-Culture**

Watch this on YT https://www.youtube.com/watch?v=BglB-uycPTo

The script creates CSV files for every year and month, and adds a header to each file using AbbreviatedMonthNames from your system settings.

The script uses Get-Culture to read the short month names for your current Windows culture, such as Jan, Feb, Mar … Dec. These names are stored in the $months variable.


**3. Get-ChildItem**

Watch this on YT https://www.youtube.com/watch?v=GQlU3MC9dVw

The script searches a source folder for files like 2024_Sep.csv using Get-ChildItem, filtering for filenames that contain an underscore ("*_*").

It then reads the year from each filename (using the BaseName, without the file extension), creates the required year folders (for example, 2024) with New-Item, and copies each file into the correct organised subfolder using Copy-Item.

When the script finishes, it displays a message with Write-Host showing which file was copied and where it was placed.


**4. Power Shell in VSCode**

Watch this on YT https://www.youtube.com/watch?v=qnjkVDlfuvM

No repository, recording only about PowerShell extension in Visual Studio Code


**5. LastWriteTime**

Watch this on YT https://www.youtube.com/watch?v=X6QG26NXuWU

The script reads the "Date Modified" (LastWriteTime) from each file (not folders) and automatically MOVES (Move-Item) them into newly created folders like 2024 > 2024_09.

This is a perfect solution for organising reports, photos, documents, or downloads based on when they were last changed.

To create an environment for testing, I used the script Get_Random.ps1 that created random files.

In addition, script Name_LastWriteTime.ps1 shows in the terminal Name and Date Modified.

**6. Rename_byDate_Taken**

Watch this on YT https://www.youtube.com/watch?v=Rwl1cXkKKx0

The PowerShell script uses the actual "Date Taken", not file system dates.

A simple but practical example of using metadata correctly and writing safer automation scripts.

In addition, the script Show_DateTaken.ps1 shows in the terminal list of the jpg files and the "Date Taken"

**7. ImportExcel_HTML**

Watch this on YT https://www.youtube.com/watch?v=Nu_Dbqeowdw

ImportExcel: Pull Website Data into Excel with PowerShell

I'm using Import-Html to pull Demographics of the United Kingdom data from Wikipedia.

I installed the ImportExcel module in PowerShell - no admin rights required. Then I load the module into the current session.

After that, I use the URL to import the data. The number 9 tells PowerShell which table to extract. Tables are counted from zero, so 9 means the 10th table on the page.

This PowerShell module enables reading and writing Excel files without Microsoft Excel installed on the system.

A simple way to turn web data into structured data in seconds.

**8. GetDefaultFolder**

Watch this on https://www.youtube.com/watch?v=rWbRKujZUKs

Automating Outlook attachment downloads with PowerShell (Last 7 Days Filter)

I'm using Outlook's ComObject Outlook.Application (MAPI) to:

- Connect to Outlook desktop app
- Search the Inbox and all subfolders (GetDefaultFolder)*
- Filter emails from the last e.g. 7 days
- Find attachments containing specific text in the filename e.g. “jpg”
- Automatically save them to a chosen folder
- Safely handle duplicate filenames
- Generate a summary at the end

This kind of automation is perfect for collecting reports, saving image attachments, and processing regular email data - without manually downloading files.

**9.ConvertToXLSX**

Watch this on https://www.youtube.com/watch?v=mu5Ax5s-894

From CSV files to Excel reports with PowerShell

I'm using PowerShell with the ImportExcel module to automatically convert multiple CSV files into formatted Excel workbooks.
The script loops through a folder, processes each CSV, and creates a clean .xlsx version - saving time and keeping consistency across reports.
A quick example of how automation can make everyday data tasks faster and more reliable!

To start, install the ImportExcel module in PowerShell - no admin rights required. Then load the module into the current session.

**10.ConvertToCSV**

Watch this on https://youtu.be/pwujh_EAqmA

Excel to CSV Automation with PowerShell

I'm using PowerShell with the ImportExcel module to automatically convert multiple CSV files into formatted Excel workbooks.
The script loops through a folder, processes each CSV, and creates a clean .xlsx version — saving time and ensuring consistency across reports.
A quick example of how automation can make everyday data tasks faster and more reliable!

To start, install the ImportExcel module in PowerShell - no admin rights required. Then load the module into the current session.

**11.OutlookToCSV**

Watch this on https://www.youtube.com/watch?v=3kxgKGxrNO0

I'm using PowerShell with Outlook COM objects to export emails from the last 30 days across Inbox + all subfolders into a timestamped CSV file.
The recursive script captures sender, date, subject, and folder location (message - body - can be added too) - perfect for audits, reporting, or data analysis without manual copying.
Saves hours compared to drag-and-drop or Excel exports!

