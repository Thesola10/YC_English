md -p   .\work\Data\StreamingAssets\scrpt.cpk.contents
md -p   .\out\contents\0100D12014FC200\romfs\Data\StreamingAssets

.\inucode.py

.\3rdparty\cpkmakec.exe `
    .\work\Data\StreamingAssets\scrpt.cpk.contents `
    .\out\contents\0100D12014FC200\romfs\Data\StreamingAssets\scrpt.cpk `
    -mode=FILENAME  `
    -code=UTF-8     `
    -align=2048

Remove-Item -r .\work\Data\StreamingAssets\scrpt.cpk.contents
