# Extract Yurucamp NSP (c) Karim Vergnes <me@thesola.io>
# This script automatically pulls the titlekey from the tik file found in the
# NSP bundle, and extracts it down to the required ROMFS

md .\work

.\3rdparty\hactool.exe -x $args[0] --pfs0dir=.\work -t pfs0
.\3rdparty\hactool.exe -x .\work\97105c79474118d294c8808a22f39bd3.nca `
    --titlekey=$(Format-Hex -Path .\work\0100d12014fc2000000000000000000b.tik -Count 16 -Offset 0x180) `
    --romfsdir=.\work

Remove-Item .\work\*.nca .\work\*.tik .\work\*.cert
