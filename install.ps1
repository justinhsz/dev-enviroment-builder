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

Write-Output "First launch the new wsl may take some time..."
wsl -d $wslDistroName bash -c "/dev-install-files/initial.sh ${env:username}"
wsl -t $wslDistroName

Write-Output "Follow the instruction to complete your environment setup..."
wsl -d $wslDistroName bash -c "/dev-install-files/setup-user-environment.sh"

$yn= Read-Host -Prompt "Do you want to set the current wsl distro as default one? (y/n)"

if ( $yn -match "y" ){
    wsl --set-default $wslDistroName
}

Write-Output "Setup completed!"
wsl -d $wslDistroName