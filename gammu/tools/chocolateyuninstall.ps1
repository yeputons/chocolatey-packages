$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = 'Gammu *'
  fileType      = 'EXE'
  silentArgs   = '/S'
}

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $installLocation = Get-AppInstallLocation $packageArgs.softwareName
  if (!$installLocation)  { Write-Warning "Can't find Gammu install location"; return }

  # Actual until https://github.com/gammu/gammu/issues/595 is fixed.
  If (Get-Service GammuSMSD -ErrorAction SilentlyContinue) {
    Write-Host "Uninstalling Gammu SMSD Service"
    sc.exe delete GammuSMSD  # Remove-Service is available in PowerShell 6.0 only.
    if ($LastExitCode -ne 0) {
      throw "Failed to uninstall Gammu SMSD Service"
    }
  }

  Uninstall-BinFile -Name gammu -Path $installLocation\bin\gammu.exe
  Uninstall-BinFile -Name gammu-smsd -Path $installLocation\bin\gammu-smsd.exe
  Uninstall-BinFile -Name gammu-smsd-monitor -Path $installLocation\bin\gammu-smsd-monitor.exe
  Uninstall-BinFile -Name gammu-smsd-inject -Path $installLocation\bin\gammu-smsd-inject.exe

  $key | % {
    $packageArgs['file'] = "$($_.UninstallString)"
    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}
