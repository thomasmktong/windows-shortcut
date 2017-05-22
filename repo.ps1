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
    "C:\Progra~1\Git\git-bash.exe"
)

for ($i = 0; $i -lt $tools.length; $i++) {
    Write-Host ("$i. " + $tools[$i])
}

$selectedId = Read-Host "Select Tools"
try {
    $selectedTool = $tools[$selectedId]
    Invoke-Expression "$selectedTool"
} catch {
    Write-Host "Unknown tool, exiting..."
    exit
}