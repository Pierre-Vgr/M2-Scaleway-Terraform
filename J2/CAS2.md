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