# Bandit

## Bandit0
```bash
ssh bandit0@bandit.labs.overthewire.org -p 2220
```

bandit0
**ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If**
## Bandit1
```bash
ssh bandit1@bandit.labs.overthewire.org -p 2220
```

(Para pegar en powershell usar *click derecho* del ratón)
## Bandit2
```bash
cat ./-
cat home/bandit1/-
cat $(pwd)/-
cat $(pwd)/*
```

**263JGJPfgU6LtdEvgfWU1XP5yac29mFx**
## Bandit3
```bash
cat $(pwd)/"--spaces in this filename--"
cat $(pwd)/*
```

**MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx**
## Bandit4
```bash
cat ...Hiding-From-You
```

**2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ**
## Bandit5
```bash
cat $(pwd)/*
cat ./-file07
```

Contraseña en *-file07*
**4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw**

Esto se puede hacer comprobando el tipo de archivo que es cada uno con *file*. Para aplicar a cada fila el comando *file* se usará *xargs*
```bash
find . -name -file* | xargs file
```

ó
```bash
file inhere/*
```

## Bandit6
Nos dan una serie de condiciones para buscar el archivo en el que esta la pwd
- es archivo
- lejible
- tamaño 1033 bytes (se pone con *c* al final)
- ejecutable
```bash
find . -type f -size 1033c -readable ! -executable
```

Archivo -> *./maybehere07/.file2*
**HWasnPhtq9AVKe0dmk45nxy20cvUa6EG**
## Bandit7
```bash
find / -user bandit7 -size 33c -group bandit6 2>/dev/null
```

Archivo -> */var/lib/dpkg/info/bandit7.password*
**morbNTDkSW6jIlUc0ymOdMaLnOlFVAaj**
## Bandit8
```bash
cat data.txt | grep millionth
```

**dfwvzFQi4mU0wfNbFOe9RoWskMLg7eEc**
## Bandit9
```bash
cat data.txt | sort | uniq -u
```

**4CKMh1JI91bUIZZPXDqGanal4xvAg0JM**
## Bandit10
```bash
strings data.txt | grep "==="
```

**FGUW5ilLVJrxX9kMYMmlN4MgbpfMiqey**
## Bandit11
```bash
cat data.txt | base64 -d
```

**dtR173fZKb0RRsDFSGsg2RWnpNVj3qRr**
## Bandit12
Rotación manual de 13 letras con *tr*
```bash
cat data.txt | tr '[G-ZA-Fg-za-f]' '[T-ZA-St-za-s]' | awk 'NF{print $NF}'
```

**7x16WNeHIi5YkIhWsfFIqoognUTyj9Q4**
## Bandit13
Se trata de un archivo comprimido bastantes veces, por lo haremos un *script* que se encargue de descomprimir con *7z*.
```bash
7z l content.gzip
```

lista el archivo que se va a descomprimir
```bash
7z x content.gzip
```

descomprime el archivo
Con el comando
```bash
7z l content.gzip | grep 'Name' -A 2 | tail -n 1 | awk 'NF{print $NF}'
```

Podremos obtener solo el nombre del contenido del archivo que se va a descomprimir

Lanzar un bucle de descompresión del archivo hasta que se detecte que ya no se puede descomprimir más:
- Comprobar código de estado de comando anterior con
```bash
echo $?
```

Código de estado para un comando exitoso -> *0*
Código de estado para un comando fallido -> *1*

```bash
decompressor.sh
```

```
#!/bin/bash

name_decompressed=$(7z l content.gzip | grep 'Name' -A 2 | tail -n 1 | awk 'NF{print $NF}')
7z x content.gzip > /dev/null 2>&1

while true; do
        7z l $name_decompressed > /dev/null 2>&1

        if [ "$(echo $?)" == "0" ]; then
                #El archivo es un comprimido - seguir descomprimiendo
                decompressed_next=$(7z l $name_decompressed | 
                grep 'Name' -A 2 | tail -n 1 | awk 'NF{print $NF}')
                
                7z x $name_decompressed > /dev/null 2>&1 &&
                name_decompressed=$decompressed_next
                
        else
                #El archivo ya no es un comprimido - finalizar proceso
                cat $name_decompressed; rm data* 2>/dev/null
                exit 1
        fi
done
```

**FO5dwFsc0cbaIiH0h8J2eUks2vdTDwAn**
## Bandit14
```bash
ssh -i sshkey.private bandit14@bandit.labs.overthewire.org -p 2220
```

**MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS**
## Bandit15
Comprobar si un puerto está abierto enviandole una cadena vacía por tcp
```bash
echo '' /dev/tcp/127.0.0.0/30000
```

```bash
echo $?
```

es *0* -> abierto
Enviar cadena por *netcat*
```bash
echo 'MU4VWeTyJk8ROof1qqmcBPaLh7lDCPvS' | nc localhost 30000
Correct!
8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo
```

**8xCjnmgoKbGLhHFAZlGE5Tmu4M2tKJQo**
## Bandit16
Establecer conexión SSL con el localhost por el puerto 30001 con *openssl*
```bash
openssl s_client -connect 127.0.0.1:30001
```

Le pasamos la contraseña del nivel actual y nos devuelve la nueva passwd
**kSkvUpMQ7lBYyCM4GBPvCvT1BfWRy0Dx**
## Bandit17
Buscamos puertos abiertos con *nmap* en el rango de 31000 - 32000
```bash
nmap --open -T5 -v -n -p31000-32000 127.0.0.1
```

Probamos cuales de estos hablan *ssl*
```bash
openssl s_client -connect 127.0.0.1:31790 -ign_eof
```

Nos da una *private_key*
```bash
ssh -i id_rsa bandit17@bandit.labs.overthewire.org -p 2220
```

## Bandit18
```bash
diff passwords.old passwords.new
```

Buscamos en el archivo *password.new* que es donde se dice que está la pass
```bash
cat passwords.new | grep x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO
```

**x2gLTTjFwMOhQ8oWNbMN362QKxfRqGlO**
## Bandit19
Al conectarnos con la contraseña directamente nos echa por la configuración del *bashrc*
1) Al entablar la conexión, se pueden colar comandos antes de que la bashrc lea el código y nos eche -> ejecutamos una bash
```bash
ssh -i id_rsa bandit18@bandit.labs.overthewire.org -p 2220 bash
```

2) ssh tiene una opción para que no lea la *bashrc*
```bash
ssh -i id_rsa bandit18@bandit.labs.overthewire.org -p 2220 --norc
```

Contraseña en *readme*
**cGWpMaKXVwDUNgPAVJbWYuGHVn9zl3j8**
## Bandit20
```bash
./bandit20-do cat /etc/bandit_pass/bandit20
```

**0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO**
## Bandit21
```bash
nc -nlvp 5757
./suconnect 5757
```

En consola a la escucha con *nc*
```bash
0qXahG8ZjOVMN9Ghs7iOWsCfZyXOUbYO
```

*Password matches, sending next password*
**EeoULMCra2q0dSkYj561DX7s1CpBuOBt**
## Bandit22
```bash
cd /etc/cron.d/
nano cronjob_bandit22
nano /usr/bin/cronjob_bandit22.sh
cat /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
```

**tRae0UfB9v0UzbCdn9cY0gQnds9GF58Q**
## Bandit23
```bash
echo "I am user bandit23" | md5sum | awk '{print $1}'
```

**0Zf11ioIjMVN551jX3CmStKLYqjk54Ga**
## Bandit24
```bash
mktemp -d
chmod o+rwx ../tmp.sPET5unBcm
```

Crear un script que dumpee la contraseña del archivo */etc/bandit_pass/bandit24* mediante el proceso cron que hay corriendo
```bash
cat /etc/bandit_pass/bandit24 > /tmp/tmp.sPET5unBcm/qarlgpwned.txt
```

- Copiarlo a la carpeta donde lee el proceso
```bash
cp script.sh /var/spool/bandit24/foo/script.sh
```

Para monitorear la carpeta cada segundo
```bash
watch -n 1 ls -ls
```

Se creará un archivo *qarlgpwned.txt* con la contraseña
**gb8KRRCsshuZXI0tUuR6ypOFjiZbf3G8**
## Bandit25
Crear archivo para generar la combinatoria de 10000 números en formato PIN del 0 al 9999
```
for i in {0000..9999}; do
	echo "gb8KRRCsshuZXI0tUuR6ypOFjiZbf3G8 $i"
done
```
Volcar contenido sobre un archivo txt
```bash
./script.sh > dictionary.sh
```

Enviarlo al puerto 30002
```bash
cat dictionary.txt | nc localhost 30002
```

**iCi86ttT4KSNe1armKiwbQNmB3YJP3q4**
## Bandit26
Bandit26 no tiene una /bin/bash, si buscamos el usuario y filtramos vemos que usa un binario llamado *showtext* -> /usr/bin/showtext
```bash
cat /etc/passwd | grep bandit26
```

Al mirar qué hace ese binario vemos que emplea un comando *more* del cual nos podemos aprovechar.
**Este comando se encarga de poner un *more* en la pantalla si el contenido que muestra es más grande al tamaño de la pantalla y no se puede visualizar todo**
Podremos emplear el uso de un modo interactivo al conectarnos por ssh y lanzarnos una bash

Ejecutamos desde kali (habiendo copiado la key)
```bash
ssh -i bandit26.sshkey bandit26@bandit.labs.overthewire.org -p 2220
```

*Pulsamos "v" para entrar en modo interactivo*
```bash
:set shell=/bin/bash
:shell
```

Lo que hemos hecho es decirle a la variable *shell* que sea una bash mediante el comando ":set" que nos permite ejecutar comandos por consola desde el modo interactivo
## Bandit27
```bash
./bandit27-do cat /etc/bandit_pass/bandit27
```

**upsNCc7vzaRDx6oZC6GiR6ERwe1MowGB**
## Bandit28
Desde kali (**NO deja abrir conexiones ssh en local desde local**)
Hay que especificarle el puerto *2220*
`{python}git clone ssh://usuario@host:puerto/ruta`
```bash
git clone ssh://bandit27-git@bandit.labs.overthewire.org:2220/home/bandit27-git/repo
```

La pass está en el *README*
**Yz9IpL0sBcCeuG7m9uQFt8ZNpS4HZRcN**
## Bandit29
```bash
git clone ssh://bandit28-git@bandit.labs.overthewire.org:2220/home/bandit28-git/repo
```

Dentro de repo hacemos
```bash
git log -p
```

**4pT1t5DENaYuqnqvadYs1oE4QLCdjmJ7**
## Bandit30
Consultamos las ramas con
```bash
git branch -r
```

Vemos que hay una rama de *dev* -> Cambiamos a esa rama
```bash
git checkout dev
```

Ahora el archivo README.md nos muestra la contraseña
**qp30ex3VLz5MDG1n91YowTv4Q8l7CDZL**
## Bandit31
Hay una etiqueta oculta en el repo
```bash
git tag
git show secret
```

**fb5S2xb7bRyFmAvQYQGEqsbhVyJqhnDy**
## Bandit32
```bash
echo 'May I come in?' > key.txt
rm .gitignore
git add key.txt
```

Añadimos un commit con mensaje pero previamente tenemos que tener un un nombre y correos en git asignados
```bash
git config --global user.email "you@example.com"
git config --global user.name "OTW Name"
git commit -m "Añadimos nuevo archivo"
```

Hacemos el push con los datos nuevos a *origin master*
```bash
git push -u origin master
```

**3O9RfhqyAlVBEZpVb6LYStshZoqoSx5K**
## Bandit33
Intentaremos escapar de la shell con un comando que nos muestra en qué bash estamos
```bash
echo $0
```

```bash
$0
```

-> spawnea una bash
**tQdtbs5D5i2vJwkO8mEyYEyTL8izoeJ0**
## Bandit34
*FIN*
