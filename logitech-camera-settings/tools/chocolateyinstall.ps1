$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download01.logi.com/web/ftp/pub/techsupport/cameras/Webcams/LogiCameraSettings_2.12.20.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url

  softwareName  = 'Logitech Camera Settings'

  checksum      = '7a54eadbaf6b27e182e5cab27b62241d6be3bd99fd4b387cc38e9d700709f5c9' 
  checksumType  = 'sha256'

  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs
