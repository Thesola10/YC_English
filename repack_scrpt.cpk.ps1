md -p   .\work\Data\StreamingAssets\scrpt.cpk.contents
md -p   .\out\contents\0100D12014FC200\romfs\Data\StreamingAssets

Get-ChildItem -Path .\patches\Data\StreamingAssets\scrpt.cpk -Filter *.json |
Foreach-Object {
    Write-Output ("Encoding "+ $_.BaseName + ".json")
    python3 .\inucode.py $_.FullName | Out-File -Encoding utf8 $(Join-Path .\work\Data\StreamingAssets\scrpt.cpk.contents $_.BaseName)
}

.\3rdparty\cpkmakec.exe `
    .\work\Data\StreamingAssets\scrpt.cpk.contents `
    .\out\contents\0100D12014FC200\romfs\Data\StreamingAssets\scrpt.cpk `
    -mode=FILENAME  `
    -code=UTF-8     `
    -align=2048

Remove-Item -r .\work\Data\StreamingAssets\scrpt.cpk.contents
