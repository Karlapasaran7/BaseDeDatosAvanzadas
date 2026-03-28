 #Documentaacion de Comandos de Contenedores de SGBD

 ##Contenedores sin volumen
 **Comando para la creacion de contenedor con nombre de imagen**

 '''shell
 docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" \
   -p 1438:1433 --name servidorsqlserverDev \
   -d \
   mcr.microsoft.com/mssql/server:2025-latest

   **Comando para la creacion de contenedores de ID**
   '''shell
 docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" \
   -p 1439:1433 --name servidorsqlserverDev2 \
   -d \
   db9a


docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" \
   -p 1439:1433 --name servidorsqlserverDev2 -v volume-sqlserverdev:/var/opt/mssql \
   -d \
   db9a



