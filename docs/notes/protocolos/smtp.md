# SMTP
*Simple Mail Transfer Protocol*
Protocolo para enviar correos en una red IP. Se usa entre el cliente de correo y el servidor de salida, o entre dos servidores SMTP (uno actúa como cliente). Se combina con IMAP o POP3, que son los que recogen el correo de la bandeja.

Puerto **25 TCP** → SMTP (por defecto, sin cifrar)
Puerto **587 TCP** → envío autenticado con STARTTLS (cifra la conexión)
Puerto **465 TCP** → SMTP sobre SSL/TLS

Por defecto SMTP va en texto plano (comandos, datos y credenciales visibles). Con SSL/TLS se cifra. ESMTP es la extensión moderna: tras `EHLO` se manda `STARTTLS` para cifrar y poder usar `AUTH PLAIN` de forma segura.

*Flujo del correo*
* `MUA` (Mail User Agent) → el cliente, redacta el correo
* `MSA` (Mail Submission Agent) → valida el origen (relay server)
* `MTA` (Mail Transfer Agent) → envía/reenvía, comprueba tamaño y spam, busca en DNS la IP del destino
* `MDA` (Mail Delivery Agent) → entrega el correo al buzón del destinatario

*Debilidades del protocolo*
* No devuelve confirmación de entrega útil (solo un error en inglés si falla)
* El remitente no se autentica al conectar → se puede falsificar (**mail spoofing**). Por eso los open relays se abusan para spam. Mitigaciones: SPF, DKIM, DMARC.

## Comandos

* `AUTH PLAIN` → autentica al cliente
* `HELO` / `EHLO` → inicia la sesión (EHLO para ESMTP)
* `MAIL FROM` → remitente
* `RCPT TO` → destinatario
* `DATA` → inicia la transmisión del cuerpo (se termina con una línea con solo `.`)
* `RSET` → aborta el envío pero mantiene la conexión
* `VRFY` → comprueba si existe un buzón/usuario
* `EXPN` → comprueba si existe un buzón (listas)
* `NOOP` → pide respuesta para no cerrar por time-out
* `QUIT` → cierra la sesión

## Configuración peligrosa

El fichero de Postfix es `/etc/postfix/main.cf`. La opción clave es `mynetworks`, que define qué IPs pueden enviar a través del servidor.

* Configuración normal → `mynetworks = 127.0.0.0/8 10.129.0.0/16`
* Open relay → `mynetworks = 0.0.0.0/0` (cualquiera puede enviar correos falsos a través del servidor)

## Footprinting

* Escaneo con versión y scripts (lista los comandos soportados vía `smtp-commands`)
```bash
sudo nmap target -sC -sV -p25
```

* Detectar open relay (16 tests)
```bash
sudo nmap target -p25 --script smtp-open-relay -v
```

## Interacción manual

* Conectar con telnet e iniciar sesión
```bash
telnet target 25
HELO mail1.inlanefreight.htb
EHLO mail1
```

* Enumerar usuarios con VRFY (ojo: según config puede devolver `252` y confirmar usuarios que no existen → no fiarse del todo)
```bash
VRFY root
```

* Enviar un correo manualmente
```bash
MAIL FROM: <cry0l1t3@inlanefreight.htb>
RCPT TO: <mrb3n@inlanefreight.htb>
DATA
Subject: prueba
...texto...
.
QUIT
```

Nota: vía proxy web se puede forzar la conexión con `CONNECT target:25 HTTP/1.0`.
