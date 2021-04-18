$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://dl.cihar.com/gammu/releases/windows/Gammu-1.42.0-Windows.exe'
$url64      = 'https://dl.cihar.com/gammu/releases/windows/Gammu-1.42.0-Windows-64bit.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url64

  softwareName  = 'Gammu *'

  checksum      = '153d55328bd9e61cd387359fa82661309b6aa9c17c0b06239faea4e4e929c14d'
  checksumType  = 'sha256'
  checksum64    = 'ee57ded07d4ec2460888759ecf588e0b841cad1e4d65977148c8e6568abecc8f'
  checksumType64= 'sha256'

  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation)  { Write-Warning "Can't find Gammu install location"; return }
Write-Host "Gammu installed to '$installLocation'"

# There is Install-ChocolateyPath, but no Uninstall-ChocolateyPath (https://github.com/chocolatey/choco/issues/310),
# so I chose not to use either for cleaner uninstall.
Install-BinFile -Name gammu -Path $installLocation\bin\gammu.exe
Install-BinFile -Name gammu-smsd -Path $installLocation\bin\gammu-smsd.exe
Install-BinFile -Name gammu-smsd-monitor -Path $installLocation\bin\gammu-smsd-monitor.exe
Install-BinFile -Name gammu-smsd-inject -Path $installLocation\bin\gammu-smsd-inject.exe
