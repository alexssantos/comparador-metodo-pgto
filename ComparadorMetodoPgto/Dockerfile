#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.
#Logs details: 
#   $ docker build --progress=plain --no-cache -t pethouse-img .

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env

ENV PROJECT_PATH="ComparadorMetodoPgto.Api/ComparadorMetodoPgto.Api.csproj"
WORKDIR /build
# copia tudo DA pasta raiz (dockerfile) e abaixo PARA pasta atual do meu ambiente (build-env).
COPY . .
RUN dotnet restore $PROJECT_PATH
RUN dotnet build $PROJECT_PATH -c Release -o /app/build

FROM build-env AS publish-env
RUN dotnet publish $PROJECT_PATH -c Release -o /app/published /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime-env
EXPOSE 8080
ENV ASPNETCORE_URLS="http://+:8080"
ENV ASPNETCORE_ENVIRONMENT="Development"
# ENV PROJECT="ComparadorMetodoPgto.Api.dll"

WORKDIR /app
COPY --from=publish-env /app/published .
ENTRYPOINT ["dotnet", "ComparadorMetodoPgto.Api.dll"]