md -p   .\work\Data\StreamingAssets\scrpt.cpk.contents
md -p   .\out\contents\0100D12014FC2000\romfs\Data\StreamingAssets

python3 .\inucode.py

.\3rdparty\cpkmakec.exe `
    .\work\Data\StreamingAssets\scrpt.cpk.contents `
    .\out\contents\0100D12014FC2000\romfs\Data\StreamingAssets\scrpt.cpk `
    -mode=FILENAME  `
    -code=UTF-8     `
    -align=2048

Remove-Item -r .\work\Data\StreamingAssets\scrpt.cpk.contents
