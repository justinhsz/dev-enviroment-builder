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
    docker run --name $dockerContainerName $dockerImageName whoami
    
    $tarFilePath = "$wslDistroName.tar"
    docker export -o $tarFilePath $dockerContainerName

    docker rm $dockerContainerName
    docker rmi $dockerImageName
}

New-Item -ItemType Directory -Force -Path $wslTargetDir

compact /c /q /s:$wslTargetDir

wsl --import $wslDistroName $wslTargetDir $tarFilePath

$lowercaseUsername = ${env:username}.ToLower()
wsl -d $wslDistroName bash -c "utils/first-launch.sh $lowercaseUsername"

wsl --terminate $wslDistroName