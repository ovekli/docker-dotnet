#!/bin/bash

export DOTNET_APP=SqlDockerApp
export NUGET_REPO=https://nexus-intern.klinghed.se/repository/nuget-dotnet-group/index.json

docker run \
  --name SqlDockerApp-build \
  --rm \
  -v $(pwd):/source \
  -v $(pwd)/build:/build \
  mcr.microsoft.com/dotnet/sdk:10.0.300-azurelinux3.0-amd64 \
  /bin/bash -xc "
  cd /build && \
  dotnet nuget remove source nuget.org && \
  dotnet new console -o $DOTNET_APP --force && \
  echo $NUGET_REPO && \
  dotnet nuget add source $NUGET_REPO --name dotnet-nexus && \
  cd $DOTNET_APP && \
  dotnet add package Microsoft.Data.SqlClient && \
  dotnet add package Dapper && \
  cp /source/Program.cs /build/$DOTNET_APP && \
  dotnet publish
  "