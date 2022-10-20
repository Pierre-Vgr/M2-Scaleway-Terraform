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