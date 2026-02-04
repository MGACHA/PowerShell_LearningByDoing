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

The script searches a source folder for files like 2024_Sep.csv using Get-ChildItem, filtering for filenames that contain an underscore ("*_*").

It then reads the year from each filename (using the BaseName, without the file extension), creates the required year folders (for example, 2024) with New-Item, and copies each file into the correct organised subfolder using Copy-Item.

When the script finishes, it displays a message with Write-Host showing which file was copied and where it was placed.


**4. Power Shell in VSCode**

No repository, recording only about PowerShell extension in Visual Studio Code


**5. LastWriteTime**

The script reads the "Date Modified" (LastWriteTime) from each file (not folders) and automatically MOVES (Move-Item) them into newly created folders like 2024 > 2024_09.

This is a perfect solution for organising reports, photos, documents, or downloads based on when they were last changed.


**6. Rename_byDate_Taken**

The PowerShell script uses the actual "Date Taken", not file system dates.

A simple but practical example of using metadata correctly and writing safer automation scripts.
