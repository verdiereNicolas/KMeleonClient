[string]$installFolder = Get-Location
Write-host $installFolder"\vcxsrv.exe"
Write-host "Activation du mode développeur"
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux 

Write-host "Ajout du sous-système linux"
#Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile Ubuntu.appx -UseBasicParsing

Write-host "Installation de la distribution ubuntu"
Add-AppxPackage .\Ubuntu.appx

Write-host "Installation du serveur X11"
start-process -FilePath $installFolder"\vcxsrv.exe" -Verb runas

Write-host "Copie installateur bash"
Copy-Item $installFolder"\KMInstaller.sh" -Destination "C:\KMeleon"

Write-host "Installation de KMeleon"
start-process bash -Verb runas -ArgumentList "-file /mnt/c/KMeleon/KMInstaller.sh"

Start-Sleep -s 15

Write-host "creation raccourci "
#CREATION D UN RACCOURCI A METTRE A LA FIN DU CODE INSTALL KMELEON
[string]$installFolderr = Get-Location

# Create a Shortcut with Windows PowerShell
$DesktopPath = [Environment]::GetFolderPath("Desktop")

Write-host $installFolderr 
Write-host $DesktopPath

Start-Sleep -s 15

#CREATION DU RACCOURCI

$SourceFileLocation = "C:\Windows\System32\bash.exe -c `"export DISPLAY=:0 && cd /home/tesseract && /home/tesseract/build-Kmeleon-Desktop-Release/KMeleon`""
$ShortcutLocation = $DesktopPath + "\KMeleon.lnk"
$ShourcutIconLocation = $installFolderr + "\kmeleonIcon.ico"

#New-Object : Creates an instance of a Microsoft .NET Framework or COM object.
#-ComObject WScript.Shell: This creates an instance of the COM object that represents the WScript.Shell for invoke CreateShortCut

$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutLocation)
$Shortcut.TargetPath = "powershell.exe"
$Shortcut.Arguments = "-noexit -ExecutionPolicy Bypass -File C:\Users\flori\Documents\WindowsInstaller\KMeleon.ps1"
$Shortcut.IconLocation = $ShourcutIconLocation

#Save the Shortcut to the TargetPath
$Shortcut.Save()
Start-Sleep -s 15




