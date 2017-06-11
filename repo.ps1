Split-Path $MyInvocation.MyCommand.Path | Set-Location

$projects = Get-ChildItem ../

Write-Host "`nProjects:"
for ($i = 0; $i -lt $projects.length; $i++) {
    Write-Host ("$i. " + $projects[$i].Name)
}

$selectedId = Read-Host "Select project"
try {
    $selectedProject = $projects[$selectedId]
    Set-Location $selectedProject.FullName
    $newLocation = Get-Location
    Write-Host "Changed path to $newLocation"
} catch {
    Write-Host "Unknown project, exiting..."
    exit
}

$commandCache = ".\.repo-command"
if (Test-Path $commandCache) {
    [string[]] $lineCache = Get-Content $commandCache -Delimiter "`n"
    if ($lineCache.length -gt 0) {
        Write-Host "`nCommands:"
        for ($i = 0; $i -lt $lineCache.length; $i++) {
            Write-Host ("$i. " + $lineCache[$i] -replace "`n", "" -replace "`r", "")
        }
        $selectedId = Read-Host "Select your commands, or hit ENTER to use prebuild commands"
        try {
            if ($selectedId) {
                $selectedCommand = $lineCache[$selectedId]
                Write-Host "Trying to call $selectedCommand..."
                Invoke-Expression "$selectedCommand" | Out-Default
                exit
            }
        } catch {
            Write-Host "Error!"
        }
    }
}

$commands = @(
    "start .",
    "code .",
    "jupyter notebook",
    "tensorboard.bat"
)

Write-Host "`nCommands:"
for ($i = 0; $i -lt $commands.length; $i++) {
    Write-Host ("$i. " + $commands[$i])
}

$selectedId = Read-Host "Select prebuild commands or type in your own commands"
try {
    $selectedCommand = $commands[$selectedId]
    if (!$selectedCommand) {
        throw
    }
    Write-Host "Trying to call $selectedCommand..."
    Invoke-Expression "$selectedCommand" | Out-Default
} catch {
    $selectedCommand = $selectedId
    Write-Host "Trying to call $selectedCommand..."
    Invoke-Expression $selectedCommand | Out-Default
} finally {
    if (Test-Path $commandCache) {
        [string[]] $lineCache = Get-Content $commandCache -Delimiter "`n"
        Set-Content -Path $commandCache -Value $selectedCommand
        foreach ($eachLineCache in ($lineCache | Select-Object -First 2)) {
            Add-Content -Path $commandCache -Value ($eachLineCache -replace "`n", "" -replace "`r", "")
        }
    }
    else {
        Set-Content -Path $commandCache -Value "$selectedCommand"
    }
}

Write-Host "`nExit in 10 seconds..."
Start-Sleep -s 10