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

Enter a valid access-key: SCWYJJHCEN3TR4P74NHG

Enter a valid secret-key: b3f2da2d-2dfc-4896-80d3-d9c399e501a6
```

### Création de l'instance

```
scw rdb instance create project-id=59972b2a-5ceb-447d-9266-ef00f9591ce1 name=rdom-pvig engine=MySQL-8 user-name=admin password=Azerty77* node-type=DB-DEV-S is-ha-cluster=false disable-backup=true volume-type=lssd backup-same-region=true region=fr-par

```