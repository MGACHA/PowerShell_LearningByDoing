#   List all files in the testfolder3 directory with their names and last write times

Get-ChildItem -Path "C:\Temp\PowerShell\testfolder3" -File 
| Select-Object Name, LastWriteTime
