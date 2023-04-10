param (
    [Parameter(Mandatory=$true)]
    [string]$wslDistroName,

    [Parameter(Mandatory=$true)]
    [string]$wslTargetDir,

    [Parameter(Mandatory=$false)]
    [string]$tarFilePath
)

if (-not $tarFilePath) {
    $dockerImageName = "wsl-import-image"
    docker build -t $dockerImageName .

    $dockerContainerName = "wsl-import-container"
    docker run --name $dockerContainerName $dockerImageName ls /
    
    docker export $dockerContainerName > $tarFilePath

    docker rm $dockerContainerName
    docker rmi $dockerImageName
}

compact /c /q /s:$wslTargetDir

wsl --import $wslDistroName $wslTargetDir $tarFilePath

wsl -d $wslDistroName bash -ic utils\first-launch.sh %USERNAME%

wsl --terminate $wslDistroName