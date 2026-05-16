
## RUNTIME
FROM mcr.microsoft.com/dotnet/aspnet:10.0.8-azurelinux3.0-amd64 as runtime

RUN mkdir /app
COPY build/SqlDockerApp/bin/Release/net10.0 /app/

ENTRYPOINT ["/app/SqlDockerApp"]