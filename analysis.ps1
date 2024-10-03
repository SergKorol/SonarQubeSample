# Check if dotnet-sonarscanner is installed
$installedTools = dotnet tool list --global

if ($installedTools -notcontains "dotnet-sonarscanner") {
    Write-Host "dotnet-sonarscanner not found. Installing..."
    dotnet tool install --global dotnet-sonarscanner
} else {
    Write-Host "dotnet-sonarscanner is already installed."
}

# Verify the installation
dotnet sonarscanner --version

# Set the SonarQube token as an environment variable
$env:SONAR_TOKEN = "sqa_25e969f1688087c040c255e56b4dba6edf89bc8d"

# Start SonarQube analysis
dotnet sonarscanner begin /k:"SonarQubeSample" `
    /d:sonar.host.url="http://localhost:9000" `
    /d:sonar.token=$env:SONAR_TOKEN

# Build the project
dotnet build .\SonarQubeSample.csproj --no-incremental

# End SonarQube analysis
dotnet sonarscanner end /d:sonar.token=$env:SONAR_TOKEN
