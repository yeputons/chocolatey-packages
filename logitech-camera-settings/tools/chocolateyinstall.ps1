$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download01.logi.com/web/ftp/pub/techsupport/cameras/Webcams/LogiCameraSettings_2.12.8.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'Logitech Camera Settings'

  checksum      = '4a18682e139a4bf665f7bf348c2887e52c656c1c4b3797817a2849668808bb97'
  checksumType  = 'sha256'

  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
