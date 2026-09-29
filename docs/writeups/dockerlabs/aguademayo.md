# AguaDeMayo

En el F12 de la web se encuentra un código en *Brainfuck*

```text
++++++++++[>++++++++++>++++++++++>++++++++++>++++++++++>++++++++++>++++++++++>++++++++++++>++++++++++>+++++++++++>++++++++++++>++++++++++>++++++++++++>++++++++++>+++++++++++>+++++++++++>+>+<<<<<<<<<<<<<<<<<-]>--.>+.>--.>+.>---.>+++.>---.>---.>+++.>---.>+..>-----..>---.>.>+.>+++.>.
```

Se pasa por el traductor de *Brainfuck*
**bebeaguaqueessano**

Con gobuster se obtiene un directorio *images*
vemos una imagen llamada *agua_ssh* -> por esteganografía no se obtiene info
- usamos "agua" como usuario para ssh y accedemos

## Escalada

`sudo -l`
*(root) NOPASSWD: /usr/bin/bettercap*

*gtfobins* para escalar -> no tiene info sobre bettercap

1. Abrimos */urt/bin/bettercap*
2. Cuando desde la consola de bettercap ejecutamos `!whoami`, bettercap lanza ese comando usando los permisos del proceso actual — que **son root**, porque mejorcap fue arrancado por `sudo`.
