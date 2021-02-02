#Enable PowerShell Remote
Enable-PSRemoting -Force

#Disable Local Firewall
Set-NetFirewallProfile -Profile * -Enabled False

#Create HTTP listerner for WinRM connection
#New-Item -Path WSMan:\localhost\Listener\ -Transport HTTP -Address * 

#Restart WinRM Service
Restart-Service WinRM

#Powershell security setting so we can run our scripts
set-executionpolicy bypass -Force

#Create Veeam Service Account
New-LocalUser -AccountNeverExpires:$true -Password ( ConvertTo-SecureString -AsPlainText -Force 'Veeam123!') -Name 'Veeam_SVC' | Add-LocalGroupMember -Group administrators

#Mount remote shares for scripts
net use p: "\\10.0.0.2\share\Veeam\B & R\v11 RC" /user:APLABS\MichaelCade Veeam123!
net use v: "\\10.0.0.2\share\CADE\Scripts\BR-UnattendedInstall-v10" /user:APLABS\MichaelCade Veeam123!

Powershell.exe -file V:\MountVBR_ISO.ps1

Powershell.exe -Command V:\Install_Veeam.ps1 -InstallOption VBRServerInstall


Write-Progress -Activity "Import Module" 
Import-module -name "C:\Program Files\Veeam\Backup and Replication\Console\Veeam.Backup.PowerShell\Veeam.Backup.PowerShell.psd1"

Powershell.exe -file V:\VeeamConfiguration.ps1
