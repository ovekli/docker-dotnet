# docker-dotnet
Dotnet create package and publish to nexus nuget repository
- dotnet new classlib -o mylib
- In .cproj file add
  <PackageId>Contoso.08.28.22.001.Test</PackageId>
  <Version>1.0.0</Version>
  <Authors>your_name</Authors>
  <Company>your_company</Company>
  <GeneratePackageOnBuild>true</GeneratePackageOnBuild>
- Build package:
  dotnet pack
  or
  dotnet build

Nexus create nuget repo
- Add user
- Login with the user created above and goto account page.
- Select menu choice NuGet API Key
- Enter password to access the key

Dotnet pulish package
- command
  dotnet nuget push bin/Debug/Contoso.08.28.22.001.Test.1.0.0.nupkg --api-key <key> --source <address to repo> 
  
