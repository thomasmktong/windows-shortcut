
$files = Get-ChildItem -Path ./ -Include @(
    "checkpoint", "*.pbtxt", "*.ckpt*", "*.tfevents*"
) -Recurse

[string[]] $filePaths = $files | ForEach-Object { Split-Path $_.FullName } | Select-Object -Unique

Write-Host "`nTensorFlow Log Directory:"
for ($i = 0; $i -lt $filePaths.length; $i++) {
    Write-Host ("$i. " + $filePaths[$i])
}

$selectedId = Read-Host "Select Log Directory"
$selectedLogDir = $filePaths[$selectedId]

Set-Location $selectedLogDir
Invoke-Expression "explorer.exe http://localhost:6006"
Invoke-Expression "tensorboard --logdir='$selectedLogDir'"