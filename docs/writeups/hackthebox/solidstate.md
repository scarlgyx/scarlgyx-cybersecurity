# SolidState

![](../../assets/img/Pasted_image_20260825115535.png)

- Whatweb
http://10.129.49.215 [200 OK] Apache[2.4.25], Country[RESERVED][ZZ], Email[webadmin@solid-state-security.com], HTML5, HTTPServer[Debian Linux][Apache/2.4.25 (Debian)], IP[10.129.49.215], JQuery, Script, Title[Home - Solid State Security]

- 80
Vemos una web de servicios de ciberseguridad pero no vemos nada a priori

- 110
Vemos que es común que haya un *pop3*

![](../../assets/img/Pasted_image_20260825120318.png)

Intentamos conectarnos con telnet al *pop3*
```bash
telnet 10.129.49.215 110
```

![](../../assets/img/Pasted_image_20260825120635.png)

Buscamos comandos que podamos usar

![](../../assets/img/Pasted_image_20260825120653.png)

En principio tenemos que logearnos y no tenemos credenciales, nos pone **-ERR** cuando intentamos conectanos con el usuario webadmin@solid-state-security.com

- 119
Servidor NNTP

![](../../assets/img/Pasted_image_20260825121558.png)

Intentamos conectarnos con nc
```bash
nc 10.129.49.215 119
```

![](../../assets/img/Pasted_image_20260825121648.png)

![](../../assets/img/Pasted_image_20260825121847.png)

- Intentamos enumerar información
```bash
list
```

![](../../assets/img/Pasted_image_20260825121911.png)

No vemos ningún contenido dentro de los grupos de noticias

- 4555
Vemos que por defecto puede ser que corra un Apache James Server

![](../../assets/img/Pasted_image_20260825122705.png)

Nos pide un id
- buscamos en google que las credenciales por defecto de *JAMES Remote Administration Tool* es root:root

![](../../assets/img/Pasted_image_20260825122827.png)

- Estamos dentro, vamos a ver qué comandos podemos usar con help

![](../../assets/img/Pasted_image_20260825122858.png)

```bash
listusers
```

![](../../assets/img/Pasted_image_20260825122931.png)

Vemos 5 cuentas
james, thomas, john, mindy y mailadmin

- Podemos cambiarle la contraseña a james por ejemplo

![](../../assets/img/Pasted_image_20260825123059.png)

Intentaremos cambiarsela a **mailadmin** para intentar acceder desde el **POP3**
```bash
setpassword mailadmin mailadmin
```

- Conseguimos conectarnos al POP3

![](../../assets/img/Pasted_image_20260825123425.png)

mailadmin:mailadmin
Enumeramos el contenido de la bandeja de entrada con STAT pero no hay ningún correo

- Cambiamos la contraseña al resto de usuarios

![](../../assets/img/Pasted_image_20260825123803.png)

- Para el usuario **mindy** vemos dos correos

![](../../assets/img/Pasted_image_20260825124043.png)

```bash
retr 1
```

![](../../assets/img/Pasted_image_20260825124110.png)

```bash
retr 2
```

![](../../assets/img/Pasted_image_20260825124130.png)

Vemos unas credenciales en ssh
mindy:P@55W0rd1!2@

- Nos intentamos conectar por ssh
```bash
ssh mindy@10.129.49.215
```

mindy

## Escalada

- Tenemos una restricted bash
Pulsamos dos veces *Tab* para ver posibles comandos que podemos usar
No vemos ninguno explotable como *tar* a priori

- Buscando encuentro que podemos ejecutar una bash por ssh
```bash
ssh mindy@10.129.49.215 bash
```

Conseguimos spawnear una bash

- Usuarios -> *mindy*, *james*, *root*

- Vemos que corre un CUPS en el puerto 631 y que no es accesible desde fuera, hacemos un local port forwarding y  accedemos a un panel de control de cups en nuestra máquina

- Vemos un proceso que corre por root -> */bin/sh /opt/james-2.3.2/bin/run.sh*
```bash
ssh mandy@10.129.49.215 -L 631:127.0.0.1:631 bash
```

![](../../assets/img/Pasted_image_20260825140904.png)

Probamos varias vulnerabilidades de **CUPS 2.2.1** pero no funciona ninguno a priori por tener el puerto 631 no expuesto

- Nos creamos un script en bash que monitorice los procesos que corren en la máquina

![](../../assets/img/Pasted_image_20260825142201.png)

Al ejecutarlo vemos el siguiente proceso:
Lo ejecutamos
```bash
./procmon.sh
```

Vemos un .py ejecutado

![](../../assets/img/Pasted_image_20260825142417.png)

Pertenece a root y es modificable por todo el mundo

![](../../assets/img/Pasted_image_20260825142508.png)

- Modificamos el archivo

![](../../assets/img/Pasted_image_20260825143037.png)

- Esperamos a que se ejecute de nuevo el proceso a ver si es ejecutado por root y cambia el permiso SUID a la bash
```bash
watch n1 ls -l /bin/bash
```

![](../../assets/img/Pasted_image_20260825143314.png)

```bash
/bin/bash
```

root
