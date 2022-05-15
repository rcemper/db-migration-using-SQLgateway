# db-migration-using-SQLgateway #  
Sample repository to show how to migrate from PostgreSQL to InterSystems IRIS    
**using SQLgateway** in differnce to using an external tool as DBeaver or similar.   
I especially try to demonstrate the comfort in fitting underlaying naming limitations. 
## Credits ##
0. OEX package [migration-pg-iris-dataset](https://openexchange.intersystems.com/package/migration-pg-iris-dataset) 
provided by [YURI MARX PEREIRA GOMES](https://openexchange.intersystems.com/user/YURI%20MARX%20PEREIRA%20GOMES/QKGV1uPuZml09uNsC8bNKcRQj8)   
    - Special thanks as this was an excellent base to start off.  
    
1. Article about PostgreSQL into Docker: 
    - https://levelup.gitconnected.com/creating-and-filling-a-postgres-db-with-docker-compose-e1607f6f882f
2. Git project created from: 
    - https://github.com/jdaarevalo/docker_postgres_with_data
    - https://github.com/intersystems-community/iris-docker-zpm-usage-template

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation 
Clone/git pull the repo into any local directory
```
git https://github.com/isc-at/db-migration-using-SQLgateway.git
```
1. Build
```
docker-compose build
```
2. Run it in foreground. Sometimes container start is slower than estimated.  
```
docker-compose up
```
  - Wait for confirmation from postgres container:  **ready to accept connections**
```
postgres_1  | 2022-01-02 15:37:27.654 UTC [1] LOG:  database system is ready to accept connections
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
   In order to make this demo faster, size of tables to migrate have been shrinked a bit.    
## How to test ##
All migration actions can be executed directly from SMP.   
1. Verify the gateway connection in    
   SMP> Administration> Configuraation >Connectivity >SqlGateway_Configuration    
 ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty01.jpg) 
   - To test Connection click **edit**    
 ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty02.jpg)    
   - and **Test Connection**    
 ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty03.jpg)    
   - verify **Connection successful**    
   - Be patient at this point. Postgres Containers sometimes take quite some time to talk to you.   
     wait a little bit, reload the page in browser and try the test again.      
   
2. Identifying the source tables. In SMP > Change to Namespace USER   
  then step to SMP >Explorers >SQL >Wizards > Data Migration   
  ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty04.jpg)
  
3. Set required import parameters  
  ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty05.jpg)
  -  Destination Namespace   
  -  Type = TABLE   
  -  Gateway = postgres ; now the first connection is established and you select 
  -  Schema = public
  -  Tables to migrate = all   

4. Identify target but change schema to be OEX compatible from **public** to **dc_public**   
  ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty06.jpg)
  - don't forget to click **change all**    
  - we migrate Definitions and Data so both sides are selected   

5. Skipping special setting we use defaults we start the task in background      
  ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty07.jpg) 
  
6. Now we check the results and see everything was working without Errors
  ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty08.jpg)    
  You might see errors if tables depend on content not yet migrated.   
  And wait for completions until the status shows **Done** 
  
7. We terminate the Migration Wizzard and return to normal table view filtered by **dc\***
  ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty09.jpg)   
  All 8 tables are visible and show meaningful columns
  
8. Selecting a table and clicking on **OpenTable** shows resonable contents   
  ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty10.jpg)   
  ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty11.jpg)
  
9. A look into the related generated Class Defnitions confirms the result and successful completion.
  ![](https://raw.githubusercontent.com/rcemper/db-migration-using-SQLgateway/master/docs/gty12.jpg)

  [Article on DC](https://community.intersystems.com/post/db-migration-using-sqlgateway)

[Demo Server SMP](https://migration-using-sqlgty.demo.community.intersystems.com/csp/sys/UtilHome.csp)   
[Demo Server WebTerminal](https://migration-using-sqlgty.demo.community.intersystems.com/terminal/)    
        
**Code Quality**  this is all setup no code involved   
<img width="85%" src="https://openexchange.intersystems.com/mp/img/packages/1785/screenshots/xo8izitp8209zylu2m9oblvkiu4.jpg">
