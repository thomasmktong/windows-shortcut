Split-Path $MyInvocation.MyCommand.Path | Set-Location

$projects = Get-ChildItem ../

Write-Host "`nProjects:"
for ($i = 0; $i -lt $projects.length; $i++) {
    Write-Host ("$i. " + $projects[$i].Name)
}

$selectedId = Read-Host "Select Project"
try {
    $selectedProject = $projects[$selectedId]
    Set-Location $selectedProject.FullName
    $newLocation = Get-Location
    Write-Host "Changed path to $newLocation"
} catch {
    Write-Host "Unknown project, exiting..."
    exit
}

Write-Host "`nTools:"
$tools = @(
    "start .",
    "code .",
    "jupyter notebook",
    "tensorboard.bat",
    ".\run.bat"
)

for ($i = 0; $i -lt $tools.length; $i++) {
    Write-Host ("$i. " + $tools[$i])
}

$selectedId = Read-Host "Select Tools"
try {
    $selectedTool = $tools[$selectedId]
    Write-Host "Trying to call $selectedTool..."
    Start-Process "$selectedTool" | Out-Default
} catch {
    Write-Host "Trying to call $selectedId..."
    Start-Process $selectedId | Out-Default
}