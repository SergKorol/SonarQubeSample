#!/bin/bash

# Check if dotnet-sonarscanner is installed
if ! dotnet tool list --global | grep -q "dotnet-sonarscanner"; then
    echo "dotnet-sonarscanner not found. Installing..."
    dotnet tool install --global dotnet-sonarscanner
else
    echo "dotnet-sonarscanner is already installed."
fi

# Verify the installation
dotnet sonarscanner --version

# Set the SonarQube token as an environment variable
export SONAR_TOKEN="sqa_25e969f1688087c040c255e56b4dba6edf89bc8d"

# Start SonarQube analysis
dotnet sonarscanner begin /k:"SonarQubeSample" \
    /d:sonar.host.url="http://localhost:9000" \
    /d:sonar.token="$SONAR_TOKEN"

# Build the project
dotnet build ./SonarQubeSample.csproj --no-incremental

# End SonarQube analysis
dotnet sonarscanner end /d:sonar.token="$SONAR_TOKEN"
