# CAS 1
## Installation de chocolatey

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

## Installation du packet SCW

```
choco install scaleway-cli
```

## Connexion a SCW

```
scw init

Enter a valid access-key: SCWYJJHCEN******

Enter a valid secret-key: b3f2da2d-2dfc-4896-80d3-**************
```

## récupération de l'id de projet

```
curl https://api.scaleway.com/account/v1/tokens/SCWYJJHCEN3TR4P74NHG -H "X-Auth-Token:b3f2da2d-2dfc-4896-80d3-d9c399e501a6"
```

<!-- à corriger ? -->

## Création de l'instance

```
scw rdb instance create project-id=59972b2a-5ceb-447d-9266-ef00f9591ce1 name=rdom-pvig engine=MySQL-8 user-name=admin password=********** node-type=DB-DEV-S is-ha-cluster=false disable-backup=false volume-type=lssd backup-same-region=true region=fr-par

```

## Récuperation de l'id de base

```
scw rdb instance list

```

Output :

```
ID                                    NAME                       NODE TYPE  STATUS  ENGINE         REGION
b5562dfb-e4cb-4f44-9a8b-26c34c9842b5  db-cas1                    db-dev-s   ready   MySQL-8        fr-par
73497de8-0410-4d3a-b1cb-5ea831f0b04c  ihsan-nathan               db-gp-xs   ready   MySQL-8        fr-par
2017ab99-9e33-4c18-bd0b-f88c9ee1dbb9  DB-GRP-08                  db-gp-xs   ready   MySQL-8        fr-par
61978d47-7309-4aaa-8007-ef8a3f008d78  rdb-TP1                    db-dev-s   ready   MySQL-8        fr-par
76a5ff84-e6ca-43c4-bdaf-bc608bacdbfc  rdb-antoine-pierre         db-dev-s   ready   MySQL-8        fr-par
3240b18c-8626-42c5-a830-d3b6e1817ffc  tp1-database               db-gp-xs   ready   MySQL-8        fr-par
cf7a4076-6e88-42f0-83c3-cf6815d97316  rdb-valentin-clement       db-dev-s   ready   MySQL-8        fr-par
746fccd6-2c12-478f-a5c7-18630cb2c541  tp1-database               db-gp-xs   ready   MySQL-8        fr-par
67ddc204-7195-408f-906b-9fb6633a9d68  cli-ins-peaceful-rosalind  db-dev-s   ready   PostgreSQL-14  fr-par
a4c1ea04-e977-4c9d-9c8d-578f6b69ec27  rdb-cas1                   db-dev-s   ready   PostgreSQL-14  fr-par
48d36276-0238-4eb8-a148-aa1582740b0f  CloudinfraInstance-DB      db-dev-s   ready   MySQL-8        fr-par
a1b0a77f-85e5-4f4f-bc8c-e7d44c3d6412  db-tp-cas1                 db-gp-xs   ready   MySQL-8        fr-par
e150c726-4d27-42ad-973d-3f538f86b7e9  rdb-group9                 db-gp-xs   ready   MySQL-8        fr-par
e0b71969-c33a-4351-9bf0-d5d5727d12af  rdom-pvig                  db-dev-s   ready   MySQL-8        fr-par
```


## Création de la base

```
scw rdb database create instance-id=e0b71969-c33a-4351-9bf0-d5d5727d12af name=test
```

## Création de la table


<!-- ### Ajout de la variable d'environement MySQL

![](variable.png)

### Connexion à la base via CLI local
```
scw rdb instance connect e0b71969-c33a-4351-9bf0-d5d5727d12af database=test username=admin region=fr-par
``` -->
```
mysql -h 51.159.207.166 --port 32485 -p -u admin

mysql> USE test;
mysql> CREATE TABLE userpvig (
    nom varchar(255),
    prénom varchar(255),
    mail varchar(255 
);

mysql> SHOW TABLES;

+----------------+
| Tables_in_test |
+----------------+
| User           |
| userpvig       |
+----------------+
2 rows in set (0.02 sec)
```

## Création des utilisateurs    

INSERT INTO userpvig  VALUE 
('John','Roberts','john.roberts@ynov.com'),
('Billy','Bogus','billy.bogus@ynov.com'),
('Claude','Nuage','claude.nuage@ynov.com'),
('Jean','Phillipe','jean.phillipe@ynov.com');



## Création du Backup de la BDD

```
scw rdb backup create instance-id=e0b71969-c33a-4351-9bf0-d5d5727d12af database-name=test name=rdombackup region=fr-par

Output:
ID            ac995cb9-65c8-421c-9cb4-3e4d9cc9afb4
InstanceID    e0b71969-c33a-4351-9bf0-d5d5727d12afDatabaseName  test
Name          rdombackup
Status        creatingCreatedAt     1 second from now
InstanceName  rdom-pvig
Region        fr-parSameRegion    true
```

### Suppression de la table User
```
USE test
DROP TABLE User;

Output :
Query OK, 0 rows affected (0.07 sec)
```

### Restauration Backup de la BDD
```
scw.exe rdb backup restore ac995cb9-65c8-421c-9cb4-3e4d9cc9afb4 database-name=test instance-id=e0b71969-c33a-4351-9bf0-d5d5727d12af region=fr-par

Output:
ID            ac995cb9-65c8-421c-9cb4-3e4d9cc9afb4
InstanceID    e0b71969-c33a-4351-9bf0-d5d5727d12af
DatabaseName  test
Name          rdombackup
Status        restoring
Size          948 B
CreatedAt     27 minutes ago
UpdatedAt     27 minutes ago
InstanceName  rdom-pvig
Region        fr-par
SameRegion    true
```

---

# CAS 2 - SCW

## Création d'un namespace

```
scw function namespace create name=test-pvig project-id=59972b2a-5ceb-447d-9266-ef00f9591ce1
```
Output :
```
ID                   1a91cfc9-1bc1-45b1-a98c-ac2b46b540ef
Name                 test-pvig
OrganizationID       b90cf4f6-2921-4c23-b5b9-60a456590666
ProjectID            59972b2a-5ceb-447d-9266-ef00f9591ce1
Status               pending
RegistryNamespaceID  -
RegistryEndpoint     -
Description          -
Region               fr-par
```
Prendre note d' l'ID

## Création d'une nouvelle fonction

```
scw function function create name=test namespace-id=1a91cfc9-1bc1-45b1-a98c-ac2b46b540ef min-scale=0 max-scale=1 timeout.seconds=69 runtime=python310 
```
Output :
```
ID              2af0d673-7f09-4b2e-8b0a-dedf13914a39
Name            test
NamespaceID     1a91cfc9-1bc1-45b1-a98c-ac2b46b540ef
Status          created
MinScale        0
MaxScale        1
Runtime         python310
MemoryLimit     256
CPULimit        140
Timeout         1 minutes 9 seconds
Handler         handler.handle
Privacy         public
Description     -
DomainName      testpvigoa7wqlqv-test.functions.fnc.fr-par.scw.cloud
Region          fr-par
HTTPOption      -
RuntimeMessage  -
```
Noter l'ID de la fonction

TO DO 
- [X] Calculate the length of my zip file
- [X] CLI: ask for S3 upload URL with content length
- [X] Use a S3 client to push my code to the S3
- [ ] CLI: call deploy funtion

Créer une archive à partir du fichier contenant notre fonction
Récupérer la taille de l'archive

```
scw function function get-upload-url ebc43ef9-96d8-40d3-8df0-add24233c21f content-length=586
```
Output:
```
https://s3.fr-par.scw.cloud/scw-database-srvless-prod/uploads/function-ebc43ef9-96d8-40d3-8df0-add24233c21f.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=SCW6Z6VKJVG81FQZVB14%2F20221025%2Ffr-par%2Fs3%2Faws4_request&X-Amz-Date=20221025T185518Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=content-length%3Bcontent-type%3Bhost&X-Amz-Signature=0d17c62355de3783ca66b2857354ee590aa50e59f9b0f78d8e1affc508c48295

``` 

Pousser la fonction grace au lien

``` 
curl -H "Content-Type: application/octet-stream" --upload-file j2/myfunction.zip -H "Content-Length: 586" "https://s3.fr-par.scw.cloud/scw-database-srvless-prod/uploads/function-ebc43ef9-96d8-40d3-8df0-add24233c21f.zip?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=SCW6Z6VKJVG81FQZVB14%2F20221025%2Ffr-par%2Fs3%2Faws4_request&X-Amz-Date=20221025T185518Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=content-length%3Bcontent-type%3Bhost&X-Amz-Signature=0d17c62355de3783ca66b2857354ee590aa50e59f9b0f78d8e1affc508c48295"
    
```


# CAS 2 - WSL
## Création d'un namespace

### Déclaration des variables

```
export TOKEN="e8737c6a-ef69-40ec-9193-617a4b8bb813"
export REGION="fr-par"
export PROJECT_ID="59972b2a-5ceb-447d-9266-ef00f9591ce1"
export NAMESPACE_NAME="test2"
```
### Création du namespace

```
curl -X POST "https://api.scaleway.com/functions/v1beta1/regions/$REGION/namespaces" -H "accept: application/json" -H "X-Auth-Token: $TOKEN" -H "Content-Type: application/json" \ -d "{\"name\": \"$NAMESPACE_NAME\", \"project_id\": \"$PROJECT_ID\"}"
```
