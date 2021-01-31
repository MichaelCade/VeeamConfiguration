#Define Mapped Drive
net use p: "\\10.0.0.2\share\Veeam\B & R\v11 RC" /user:APLABS\MichaelCade Veeam123! | Out-Null
net use v: "\\10.0.0.2\share\CADE\Scripts\BR-UnattendedInstall-v10" /user:APLABS\MichaelCade Veeam123! | Out-Null

#Variable Decalration
$isoImg = "P:\VeeamBackup&Replication_11.0.0.810.RC1.iso"

#Mount ISO and Gather Drive Letter
Mount-DiskImage -ImagePath $isoImg -PassThru | Out-Null

