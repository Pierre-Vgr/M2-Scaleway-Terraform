# CAS 3

## Création des instances

### Création instance apache1 
```
scw instance server create type=PLAY2-PICO zone=fr-par-1 image=ubuntu_jammy root-volume=b:10G additional-volumes.0=b:10G name=rdom-pvig-apache1 ip=new project-id=59972b2a-5ceb-447d-9266-ef00f9591ce1
```
### Création instance apache2 
```
scw instance server create type=PLAY2-PICO zone=fr-par-1 image=ubuntu_jammy root-volume=b:10G additional-volumes.0=b:10G name=rdom-pvig-apache2 ip=new project-id=59972b2a-5ceb-447d-9266-ef00f9591ce1
```
### Création instance apache3 
```
scw instance server create type=PLAY2-PICO zone=fr-par-1 image=ubuntu_jammy root-volume=b:10G additional-volumes.0=b:10G name=rdom-pvig-apache3 ip=new project-id=59972b2a-5ceb-447d-9266-ef00f9591ce1
```
Pour chaque instance, relever l'ID ainsi que l'IP

### Connexion en SSH aux hôtes

```
scw instance server ssh ac28076b-fbff-477e-9e0d-ca597de01994 command=apt install apache2 username=root port=22 zone=fr-par-1 
```

## Création du loadbalancer

```
scw lb lb create project-id=59972b2a-5ceb-447d-9266-ef00f9591ce1 name=rdom-pvig-lb ssl-compatibility-level=ssl_compatibility_level_modern
```
Relever l'ID du load-balancer

### Création du backend

```
scw lb backend create forward-protocol=tcp forward-port=80 lb-id=ce8f060a-10b2-4227-8075-de4cbed7bd19 forward-port-algorithm=roundrobin health-check.check-delay=2000s health-check.check-max-retries=3 health-check.check-timeout=1000s health-check.port=80 server-ip.0=163.172.130.18 server-ip.1=51.15.137.217 server-ip.2=51.159.204.202
```
noter l'ID du backend

### Création du frontend


```
scw lb frontend create inbound-port=443 lb-id=ce8f060a-10b2-4227-8075-de4cbed7bd19 backend-id=109276d3-404b-48c3-a4ca-c0db74c70e6b
```
