$ErrorActionPreference = 'Stop';
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  softwareName  = '*Wacom*'
  fileType      = 'EXE'
  silentArgs   = '/u /s'  # https://developer-docs.wacom.com/faqs/docs/q-tablet/tablet-driver#installer-command-line-parameters
}

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | % { 
    $cmd = $_.UninstallString
    $suf = ' /u'
    if ($cmd -notlike "*$suf") {
      throw "Expected uninstallation string '$cmd' to end with '$suf'"
    }

    $packageArgs['file'] = $cmd.Substring(0, $cmd.Length - $suf.Length)
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
