md  $PSScriptRoot\work\Data\StreamingAssets\scrpt.cpk.contents `
    $PSScriptRoot\out\contents\0100D12014FC200\romfs\Data\StreamingAssets

Get-ChildItem -Path $PSScriptRoot\patches\Data\StreamingAssets\scrpt.cpk -Filter *.json |
Foreach-Object {
    Write-Output "Encoding ${$_.Name}"
    python3 $PSScriptRoot\inucode.py $_.FullName > "$PSScriptRoot\work\Data\StreamingAssets\scrpt.cpk.contents\${$_.BaseName}"
}

$PSScriptRoot\3rdparty\cpkmakec.exe `
    $PSScriptRoot\work\Data\StreamingAssets\scrpt.cpk.contents `
    $PSScriptRoot\out\contents\0100D12014FC200\romfs\Data\StreamingAssets\scrpt.cpk `
    -mode=FILENAME
    -code=UTF-8
    -align=2048

Remove-Item -r $PSScriptRoot\work\Data\StreamingAssets\scrpt.cpk.contents
