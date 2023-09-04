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

wsl --import $wslDistroName $wslTargetDir $tarFilePath

wsl -d $wslDistroName bash -c "/dev-install-files/initial.sh ${env:username}"
wsl -t $wslDistroName

wsl -d $wslDistroName bash -c "/dev-install-files/setup-user-environment.sh"
wsl -d $wslDistroName