# CAS 3

## Création instance apache1 ###
```
scw instance server create type=PLAY2-PICO zone=fr-par-1 image=ubuntu_jammy root-volume=b:10G additional-volumes.0=b:10G name=rdom-pvig-apache1 ip=new project-id=59972b2a-5ceb-447d-9266-ef00f9591ce1
```
## Création instance apache2 ###
```
scw instance server create type=PLAY2-PICO zone=fr-par-1 image=ubuntu_jammy root-volume=b:10G additional-volumes.0=b:10G name=rdom-pvig-apache2 ip=new project-id=59972b2a-5ceb-447d-9266-ef00f9591ce1
```
## Création instance apache3 ###
```
scw instance server create type=PLAY2-PICO zone=fr-par-1 image=ubuntu_jammy root-volume=b:10G additional-volumes.0=b:10G name=rdom-pvig-apache3 ip=new project-id=59972b2a-5ceb-447d-9266-ef00f9591ce1
```