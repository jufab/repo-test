$checksum = "45aea652e84ae02f1000f426d8b9183bedf23aef5013d4444fa4b1da26744559"
$packageName = 'jenkins-x'
$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$nuspecPath = Resolve-Path -Path $toolsPath+'\..'
[xml]$nuspecContent = Get-Content $nuspecPath\jenkins-x.nuspec
$version = $nuspecContent.package.metadata.version
$fileZip = "jx-windows-amd64.zip"
$fileChecksums = "jx-checksums.txt"
$url = "https://github.com/jenkins-x/jx/releases/download/v$version/$fileZip"
$urlSHA = "https://github.com/jenkins-x/jx/releases/download/v$version/$fileChecksums"
$fileSHA = "$toolsPath\$fileChecksums"
Get-WebFile -Url $urlSHA -FileName $fileSHA
$matchChecksum = Select-String -Path $fileSHA -Pattern "jx-windows-amd64\.zip$"
$checksum = $matchChecksum.Line.Split(" ")[0]
$checksumtype = "sha256" 