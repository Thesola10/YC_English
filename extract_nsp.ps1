# Extract Yurucamp NSP (c) Karim Vergnes <me@thesola.io>
# This script automatically pulls the titlekey from the tik file found in the
# NSP bundle, and extracts it down to the required ROMFS

md .\work

.\3rdparty\hactool.exe -x $args[0] --pfs0dir=.\work -t pfs0

$TitleKey = (Get-Content .\work\0100d12014fc2000000000000000000b.tik -Encoding byte)[0x180..(0x180+15)]

.\3rdparty\hactool.exe -x .\work\97105c79474118d294c8808a22f39bd3.nca   `
    --titlekey=$(($TitleKey | ForEach-Object ToString x2) -join '' )    `
    --romfsdir=.\work

Remove-Item .\work\*.nca
Remove-Item .\work\*.tik
Remove-Item .\work\*.cert
