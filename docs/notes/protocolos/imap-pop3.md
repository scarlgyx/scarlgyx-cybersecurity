# IMAP / POP3
*Internet Message Access Protocol / Post Office Protocol*
Protocolos para acceder al correo almacenado en un servidor (SMTP envía, estos recogen). Basados en cliente-servidor y texto plano.

* `IMAP` → gestión online en el servidor, soporta carpetas, estructuras jerárquicas y acceso de varios clientes a la vez. Los correos quedan en el servidor y se sincronizan.
* `POP3` → más simple, solo lista, descarga y borra correos. No tiene carpetas ni gestión online.

Puerto **110 TCP** → POP3 (sin cifrar)
Puerto **995 TCP** → POP3 sobre SSL/TLS
Puerto **143 TCP** → IMAP (sin cifrar)
Puerto **993 TCP** → IMAP sobre SSL/TLS

Sin cifrado, ambos transmiten comandos, correos y credenciales en texto plano. Con SSL/TLS se usan los puertos altos (993 y 995).

## Comandos IMAP

Los comandos necesitan un tag arbitrario delante como *1* o *a*

* `1 LOGIN usuario pass` → inicia sesión
* `1 LIST "" *` → lista todos los directorios
* `1 CREATE "INBOX"` → crea un buzón
* `1 DELETE "INBOX"` → elimina un buzón
* `1 RENAME "ToRead" "Important"` → renombra un buzón
* `1 LSUB "" *` → lista buzones suscritos
* `1 SELECT INBOX` → selecciona un buzón para leer mensajes
* `1 UNSELECT INBOX` → sale del buzón
* `1 FETCH <ID> all` → recupera un mensaje
* `1 CLOSE` → borra los mensajes marcados como Deleted
* `1 LOGOUT` → cierra la conexión

_Leer correos (FETCH)_ — tras seleccionar el buzón:

- `a FETCH <ID> all` → metadatos del mensaje (flags, fecha, tamaño, cabecera sobre)
- `a FETCH <ID> body[]` → CORREO COMPLETO (cabeceras + cuerpo). El más útil para leer
- `a FETCH <ID> body[text]` → solo el cuerpo del mensaje
- `a FETCH <ID> body[header]` → solo las cabeceras (From, To, Subject...)
- `a FETCH <ID> rfc822` → el mensaje entero en formato crudo
- `a FETCH 1:* body[]` → recupera todos los mensajes del buzón de una vez
## Comandos POP3

* `USER usuario` → identifica al usuario
* `PASS pass` → autentica con contraseña
* `STAT` → número de correos guardados
* `LIST` → número y tamaño de los correos
* `RETR id` → descarga el correo indicado
* `DELE id` → borra el correo indicado
* `CAPA` → muestra las capacidades del servidor
* `RSET` → restablece la información
* `QUIT` → cierra la conexión

## Configuración peligrosa

Servidor típico: Dovecot. Opciones mal configuradas pueden filtrar info o permitir login anónimo:
* `auth_debug` → habilita logs de depuración de autenticación
* `auth_debug_passwords` → registra las contraseñas enviadas
* `auth_verbose` → registra intentos fallidos y sus motivos
* `auth_verbose_passwords` → registra las contraseñas usadas
* `auth_anonymous_username` → usuario para login con **ANONYMOUS SASL** (login anónimo, como el FTP)

## Footprinting

* Escaneo con versión y scripts (devuelve capacidades y el certificado SSL, que suele revelar el common name, la organización y la versión del servidor)
```bash
sudo nmap target -sV -p110,143,993,995 -sC
```

## Interacción

* Con cURL sobre IMAPS (lista los directorios tras autenticar)
```bash
curl -k 'imaps://target' --user usuario:pass
```

* Con `-v` para ver el handshake TLS, el certificado y el banner (versión del servidor)
```bash
curl -k 'imaps://target' --user usuario:pass -v
```

* Conexión cifrada manual con openssl (POP3S / IMAPS)
```bash
openssl s_client -connect target:pop3s
openssl s_client -connect target:imaps
```

* Herramienta *claws-mail* para loggearse con credenciales mediante IMAP -> máquina chaos.htb

Nota: también se puede usar `ncat` para interactuar. Una vez dentro, se navega con los comandos IMAP/POP3 de arriba. Si se consiguen credenciales de un empleado (p. ej. del footprinting SMTP), se usan aquí para leer su correo.
