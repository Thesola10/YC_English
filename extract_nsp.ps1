# Extract Yurucamp NSP (c) Karim Vergnes <me@thesola.io>
# This script automatically pulls the titlekey from the tik file found in the
# NSP bundle, and extracts it down to the required ROMFS

.\3rdparty\hactool.exe -x $1 --pfs0dir=.\work -t pfs0
.\3rdparty\hactool.exe -x .\work\97105c79474118d294c8808a22f39bd3.nca `
    --titlekey=$(Format-Hex -Count 16 -Offset 0x180 -Path .\work\0100d12014fc2000000000000000000b.tik) `
    --romfsdir=.\work

Remove-Item .\work\*.nca .\work\*.tik .\work\*.cert
