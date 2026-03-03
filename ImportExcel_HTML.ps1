set-location "C:\Temp\PowerShell\testfolder\"

# Install ImportExcel module means it's installed only for your user profile, without needing admin rights.
Install-Module -Name ImportExcel -Scope CurrentUser

# Loads the module into the current PowerShell session
Import-Module ImportExcel

# Download and parse the HTML from the URL. Index 9 is the table with the demographics data. Table index 0 is the first table.
Import-Html "https://en.wikipedia.org/wiki/Demographics_of_the_United_Kingdom" 9 

Import-Html "https://en.wikipedia.org/wiki/List_of_colors:_A%E2%80%93F"
