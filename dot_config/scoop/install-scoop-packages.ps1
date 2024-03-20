Get-Content .\buckets.txt |% {scoop bucket add $_}

Get-Content .\apps.txt |% {scoop install $_}

Get-Content .\apps.txt |% {scoop update $_}
