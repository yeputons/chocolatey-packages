$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
# 64-bit version only
$url64      = 'https://cdn.wacom.com/u/productsupport/drivers/win/professional/WacomTablet_6.3.42-2.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url64bit      = $url64

  softwareName  = '*Wacom*'

  checksum64    = 'fd7423f03b96af1c0d39654ce218f989cd3a09e43a11c4a52695bd6804034442'
  checksumType64= 'sha256'

  silentArgs   = '/s'  # https://developer-docs.wacom.com/faqs/docs/q-tablet/tablet-driver#installer-command-line-parameters
}

Install-ChocolateyPackage @packageArgs
