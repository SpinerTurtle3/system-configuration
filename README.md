# system-configuration

Open Terminal as Administrator

Set-ExecutionPolicy Unrestricted

winget install --id Git.Git --silent

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

md repos 

cd ./repos

git clone https://github.com/SpinerTurtle3/system-configuration

cd system-configuration

.\setup.ps1
