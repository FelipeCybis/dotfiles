
# Extract package names from Scoop list and save them to apps.txt
scoop list | ForEach-Object {
    if ($_ -match 'Name=(.+?);') {
        $matches[1]
    }
} > apps.txt

# Extract bucket names from Scoop bucket list and save them to buckets.txt
scoop bucket list | ForEach-Object {
    if ($_ -match 'Name=(.+?);') {
        $matches[1]
    }
} > buckets.txt


Write-Output "Exported Scoop packages and buckets!"


