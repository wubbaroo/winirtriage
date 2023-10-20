#setting datetime and computer name for folder and file names
$fname =  get-date -Format "yyyyMMddHHmmss$env:computername"

#creates folder of datetime and computer
New-Item -ItemType Directory -Path "C:\$fname"

#List process and modules loaded
Get-Process * -Module | fl |Out-File -FilePath "C:\$fname\$fnameProcessModules.txt"

#Copies Amcache 
Copy-Item -Path "C:\Windows\AppCompat\Programs\Amcache.hve" -Destination "C:\$fname"

#Copies SRUs 
Copy-Item -Path "C:\Windows\System32\SRU\SRUDB.dat" -Destination "c:\$fname"

#list user profiles
$profileListlocalpath = Get-ChildItem "C:\Users"

#For loop to dump user artifacts
$profileListlocalpath | ForEach-Object {
New-Item -ItemType Directory -Path "C:\$fname\$_"
Copy-Item -Path "C:\Users\$_\AppData\Local\ConnectedDevicesPlatform" -Destination "C:\$fname\$_\ConnectedDevicesPlatform" -Recurse
Copy-Item -Path "C:\Users\$_\AppData\Roaming\Microsoft\Windows\Recent\AutomaticDestinations" -Destination "C:\$fname\$_\AutomaticDestinations" -Recurse
Copy-Item -Path "C:\Users\$_\NTUSER.DAT" -Destination "C:\$fname\$_"
Copy-Item -Path "C:\Users\$_\AppData\Roaming\Microsoft\Windows\Recent" -Destination "C:\$fname\$_\WindowsRecent" -Recurse
Copy-Item -Path "C:\Users\$_\AppData\Roaming\Microsoft\Office\Recent" -Destination "C:\$fname\$_\OfficeRecent" -Recurse
} 
