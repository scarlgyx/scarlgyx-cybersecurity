# R-Services

Suite antigua de acceso remoto entre hosts Unix (Solaris, HP-UX, AIX). Reemplazada por SSH por sus fallos: transmite todo **sin cifrar** (vulnerable a MITM, como telnet).

Puertos **512, 513, 514 TCP** → r-services

*Comandos (r-commands)*:
* `rcp` (514) → copia ficheros
* `rsh` (514) → shell remota sin login
* `rexec` (512) → ejecuta comandos (pide user/pass sin cifrar)
* `rlogin` (513) → login remoto (como telnet pero solo Unix)
* `rwho` / `rusers` → lista usuarios conectados en la red

## Relaciones de confianza (el fallo clave)

Los r-services saltan la autenticación con dos ficheros de **hosts de confianza**:
* `/etc/hosts.equiv` → config global (todos los usuarios)
* `.rhosts` → config por usuario

Formato: `<usuario> <IP/hostname>`. El modificador **`+`** es un comodín = "cualquiera". Un `+ +` permite a **cualquier usuario desde cualquier host** entrar sin credenciales → mala configuración explotable.

## Footprinting y explotación

* Escaneo de los tres puertos
```bash
sudo nmap -sV -p512,513,514 target
```

* Login aprovechando un `.rhosts` mal configurado
```bash
rlogin target -l htb-student
```

* Ya dentro, listar usuarios conectados en la red (útil para sacar nombres de usuario)
```bash
rwho
rusers -al target
```

Idea de fondo: estos servicios se abusan sobre todo por credenciales débiles/por defecto y **reutilización de contraseñas**. Si ya tienes credenciales de otro sitio de la red, pruébalas aquí.
