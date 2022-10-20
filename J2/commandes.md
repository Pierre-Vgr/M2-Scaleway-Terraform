### Installation de chocolatey

```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### Installation du packet SCW
```
choco install scaleway-cli
```

### Connexion a SCW

```
scw init

Enter a valid access-key: SCWYJJHCEN******

Enter a valid secret-key: b3f2da2d-2dfc-4896-80d3-**************
```

### récupération de l'id de projet

```
$ curl https://api.scaleway.com/account/v1/tokens/$ACCESS_KEY -H "X-Auth-Token: $SECRET_KEY"
```

### Création de l'instance

```
scw rdb instance create project-id=59972b2a-5ceb-447d-9266-ef00f9591ce1 name=rdom-pvig engine=MySQL-8 user-name=admin password=********** node-type=DB-DEV-S is-ha-cluster=false disable-backup=false volume-type=lssd backup-same-region=true region=fr-par

```

### Récuperation de l'id de base

```
scw rdb instance list

```

### Création de la base

```
scw rdb database create instance-id=e0b71969-c33a-4351-9bf0-d5d5727d12af
```

### Création du Backup de la BDD

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