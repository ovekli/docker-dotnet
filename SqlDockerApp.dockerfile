# BUILD
FROM mcr.microsoft.com/dotnet/sdk:10.0.300-azurelinux3.0-amd64 as builder

ENV DOTNET_APP=SqlDockerApp
ENV NUGET_REPO=https://nexus-intern.klinghed.se/repository/nuget-dotnet-proxy/index.json

RUN mkdir -p build && \
cd /build && \
dotnet nuget remove source nuget.org && \
dotnet new console -o $DOTNET_APP && \
dotnet nuget add source $NUGET_REPO --name dotnet-nexus && \
cd $DOTNET_APP && \
dotnet add package Microsoft.Data.SqlClient && \
dotnet add package Dapper

ADD Program.cs /build/$DOTNET_APP
RUN cd /build/$DOTNET_APP && \
dotnet publish 

## RUNTIME
FROM mcr.microsoft.com/dotnet/aspnet:10.0.8-azurelinux3.0-amd64 as runtime

ENV DOTNET_APP=SqlDockerApp

RUN mkdir /app
COPY --from=builder /build/SqlDockerApp/bin/Release/net10.0 /app/

ENTRYPOINT ["/app/SqlDockerApp"]


