Split-Path $MyInvocation.MyCommand.Path | Set-Location

$Dir = get-childitem ../ -recurse
$Dir | Where-Object {$_.extension -eq ".sln"} | ForEach-Object {
    # Ref: https://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner+for+MSBuild
    # Install SonarQube MSBuild Plugin, add these to PATH: C:\Tools\sonarqube-6.3.1\bin, C:\Tools\sonarqube-6.3.1\bin\windows-x86-64
    # Add MSBuild to PATH: C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin
    $Command1 = ('SonarQube.Scanner.MSBuild.exe begin /k:"' + $_.Name + '" /n:"' + $_.Name + '" /v:"1.0"')
    $Command2 = 'MSBuild.exe ' + $_.Name + ' /t:Rebuild'
    $Command3 = 'SonarQube.Scanner.MSBuild.exe end'

    Set-Location $_.Directory
    Invoke-Expression $Command1 | Out-Default
    Invoke-Expression $Command2 | Out-Default
    Invoke-Expression $Command3 | Out-Default
}