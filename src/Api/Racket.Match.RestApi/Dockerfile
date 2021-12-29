FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["Racket.Match.RestApi/Racket.Match.RestApi.csproj", "Racket.Match.RestApi/"]
RUN dotnet restore "Racket.Match.RestApi/Racket.Match.RestApi.csproj"
COPY . .
WORKDIR "/src/Racket.Match.RestApi"
RUN dotnet build "Racket.Match.RestApi.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Racket.Match.RestApi.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Racket.Match.RestApi.dll"]
