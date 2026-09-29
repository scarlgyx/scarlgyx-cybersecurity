# Easy Peasy

![](../../assets/img/Pasted_image_20251029124324.png)

Con Gobuster solo encontramos un directorio /hidden
Volvemos a hacer gobuster sobre ese directorio y encontramos /hidden/whatever

![](../../assets/img/Pasted_image_20251029134211.png)

flag{f1rs7_fl4g}

en 10.10.13.124:65524/robots.txt hay un hash que averiguo que es md5
a18672860d0510e5ab6699730763b250
flag{1m_s3c0nd_fl4g}

En el index.html de apache de 10.10.13.124:65524/robots.txt encontramos la terceraflag
flag{9fdafbd64c47471a8f54cd3fc64cd312}

También otro código que parece el directorio oculto

![](../../assets/img/Pasted_image_20251029164202.png)

ObsJmP173N2X6dOrAgEAL0Vu
--> Probando con cyberchef vemos en está en base62:
/n0th1ng3ls3m4tt3r

Encontramos

![](../../assets/img/Pasted_image_20251029164348.png)

Haremos
`hash-identifier 940d71e8655ac41efb5f8ab850668505b86dd64186a66e57d1483e7f5fe6fd81`

![](../../assets/img/Pasted_image_20251029165312.png)

Pag https://md5hashing.net y seleccionando "search all types" para los hashes encontramos el valor
mypasswordforthatjob

![](../../assets/img/Pasted_image_20251029170840.png)

La imagen del banner parece tener un archivo oculto

![](../../assets/img/Pasted_image_20251029170559.png)

Probamos la contraseña deshasheada y se nos descarga

![](../../assets/img/Pasted_image_20251029170954.png)

El archivo tiene un cifrado binario
Intentamos descifrarlo
Vemos que es ASCII con dcode.fr

![](../../assets/img/Pasted_image_20251029171230.png)

iconvertedmypasswordtobinary

en secret aparece también el usuario
**boring:iconvertedmypasswordtobinary**

Intentamos conectarnos por ssh
`ssh boring@10.10.13.124 -p 6498`
**boring**

## Escalada

`export TERM=xterm-256color` -> no funciona xterm normal

![](../../assets/img/Pasted_image_20251029171913.png)

synt{a0jvgf33zfa0ez4y}  --> Flag rotada xd

Con dcode.fr usamos ROT cypher (de rotar) y encontramos opciones válidas:
flag{n0wits33msn0rm4l}

![](../../assets/img/Pasted_image_20251029172206.png)

Usamos linpeas
`cp /usr/share/peass/linpeas/linpeas.sh /home/qarlg/Labs/TryHackMe/easypeasy`
`chmod 666 linpeas.sh `
`scp -P 6498 linpeas.sh boring@10.10.13.124:/tmp/`
En boring
`chmod +x linpeas.sh`
`./linpeas.sh`

![](../../assets/img/Pasted_image_20251029175143.png)

Vemos un servicio cron llamado /var/www/.mysecretcronjob.sh

![](../../assets/img/Pasted_image_20251029180028.png)

Nos lanzamos una revshell

![](../../assets/img/Pasted_image_20251029182002.png)

**root**

Última flag:
`cd /root`
`ls -la`
`cat .root.txt`

![](../../assets/img/Pasted_image_20251029182054.png)
