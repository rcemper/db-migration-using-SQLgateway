# db- migration-using-SQLgateway #  
Sample repository to show how to migrate from PostgreSQL to InterSystems IRIS    
**using SQLgateway** in differnce to using an external tool as DBeaver or similar.   
I try especially to demonstrate the comfort in fitting underlaying naming limitations. 
## Credits ##
0. OEX package [migration-pg-iris-dataset](https://openexchange.intersystems.com/package/migration-pg-iris-dataset) 
provided by [YURI MARX PEREIRA GOMES](https://openexchange.intersystems.com/user/YURI%20MARX%20PEREIRA%20GOMES/QKGV1uPuZml09uNsC8bNKcRQj8)   
    - Special thanks as this was an excellent base to start off.
1. Article about PostgreSQL into Docker: 
    - https://levelup.gitconnected.com/creating-and-filling-a-postgres-db-with-docker-compose-e1607f6f882f
2. Git project created from: 
    - https://github.com/jdaarevalo/docker_postgres_with_data
    - https://github.com/intersystems-community/iris-docker-zpm-usage-template
## How to install ##
1. Build
```
docker-compose build
```
2. Run
```
docker-compose up -d
```
3. Use DBeaver to connect to the databases
    - **Connection to PostgreSQL**: 
        - host: localhost 
        - database: postgres 
        - port: 5438 
        - username: postgres 
        - password: postgres
    - **Connection to IRIS**: 
        - host: localhost 
        - database: user 
        - port: 1972 
        - username: _SYSTEM 
        - password: SYS    

4. SQLgateway is installed during Docker build and the required   
   jdbcdriver for Linux is included in this repo 
## How to test ##
All migration actions can be executed directly from SMP.   
1. Verify the gateway connection in SMP> Administration> Configuraation >Connectivity >SqlGateway_Configuration    
 ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty01.jpg) 
   - To test Connection click **edit**    
 ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty02.jpg)    
   - and **Test Connection**    
 ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty03.jpg)    
   - verify **Connection successful**   
   
2. Identifying the source tables  
