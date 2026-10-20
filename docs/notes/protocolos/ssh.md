# SSH

*Secure Shell*

Conexión cifrada y directa entre dos equipos sobre una red insegura. Permite ejecutar comandos en remoto, transferir ficheros y hacer port forwarding. **OpenSSH** es la implementación estándar en Linux.

Puerto **22 TCP** → SSH

Dos versiones del protocolo: **SSH-1** (vulnerable a MITM) y **SSH-2** (más seguro, el actual).

*Métodos de autenticación* (6 en total): password, public-key, host-based, keyboard, challenge-response, GSSAPI. La más usada es **public-key**: el cliente guarda la clave privada (protegida con passphrase) y el servidor la pública; el servidor plantea un reto que solo se resuelve con la privada.

## Configuración peligrosa (`/etc/ssh/sshd_config`)

* `PasswordAuthentication yes` → permite login por contraseña (habilita fuerza bruta)
* `PermitEmptyPasswords yes` → permite contraseñas vacías
* `PermitRootLogin yes` → permite login como root
* `Protocol 1` → versión de cifrado obsoleta
* `X11Forwarding yes` → forwarding de apps gráficas
* `AllowTcpForwarding yes` → forwarding de puertos TCP

## Footprinting

* Auditar la config y algoritmos de cifrado del servidor
```bash
./ssh-audit.py target
```

* Ver los métodos de autenticación que acepta (modo verbose)
```bash
ssh -v usuario@target
```

* Forzar un método concreto (p. ej. para fuerza bruta por password)
```bash
ssh usuario@target -o PreferredAuthentications=password
```

El **banner** revela la versión: `SSH-2.0-OpenSSH_8.2p1` = solo SSH-2, OpenSSH 8.2p1. `SSH-1.99-...` = acepta SSH-1 y SSH-2.
