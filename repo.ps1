Split-Path $MyInvocation.MyCommand.Path | Set-Location

$projects = Get-ChildItem ../

Write-Host "`nProjects:"
for ($i = 0; $i -lt $projects.length; $i++) {
    Write-Host ("$i. " + $projects[$i].Name)
}

$selectedId = Read-Host "Select Project"
$selectedProject = $projects[$selectedId]
Set-Location $selectedProject.FullName

Write-Host "`nTools:"
$tools = @("code .", "jupyter notebook", "C:\Progra~1\Git\git-bash.exe")

for ($i = 0; $i -lt $tools.length; $i++) {
    Write-Host ("$i. " + $tools[$i])
}

$selectedId = Read-Host "Select Tools"
$selectedTool = $tools[$selectedId]
Invoke-Expression "$selectedTool"