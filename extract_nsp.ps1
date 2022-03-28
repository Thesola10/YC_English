# Extract Yurucamp NSP (c) Karim Vergnes <me@thesola.io>
# This script automatically pulls the titlekey from the tik file found in the
# NSP bundle, and extracts it down to the required ROMFS

hactool -x $1 --pfs0dir=$PSScriptRoot\work -t pfs0
hactool -x $PSScriptRoot\work\97105c79474118d294c8808a22f39bd3.nca `
    --titlekey=$(Format-Hex -Count 16 -Offset 0x180 -Path $PSScriptRoot\work\0100d12014fc2000000000000000000b.tik) `
    --romfsdir=$PSScriptRoot\work

Remove-Item $PSScriptRoot\work\*.nca $PSScriptRoot\work\*.tik $PSScriptRoot\work\*.cert
