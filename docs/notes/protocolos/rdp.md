# RDP

*Remote Desktop Protocol*

Protocolo de Microsoft para acceso remoto a la **GUI** de un equipo Windows, cifrado sobre IP. Transmite comandos de visualización y control del escritorio.

Puerto **3389 TCP/UDP** → RDP

Desde Windows Vista soporta TLS/SSL, pero muchos sistemas aceptan cifrado débil (RDP Security) y usan certificados **autofirmados** por defecto → el cliente no distingue uno legítimo de uno falso (posible MITM). Por defecto solo permite conexiones con **NLA** (Network Level Authentication).

## Footprinting

* Escaneo con scripts RDP (revela si NLA está activo, versión y hostname)
```bash
nmap -sV -sC target -p3389 --script rdp*
```

Datos útiles de `rdp-ntlm-info`: `Target_Name`, nombre de equipo, dominio, versión de producto.

**Ojo**: Nmap usa cookies RDP (`mstshash=nmap`) que un EDR puede detectar y bloquearte. Usar con cuidado en redes fortificadas.

* Comprobar la config de seguridad del servidor (sin autenticación)
```bash
./rdp-sec-check.pl target
```

## Conexión

* Desde Linux con xfreerdp (también rdesktop o Remmina)
```bash
xfreerdp /u:usuario /p:"password" /v:target
```
Usuario frecuente para probar -> **Administrator**

Al conectar avisa del certificado autofirmado (`CERTIFICATE NAME MISMATCH`); se acepta con `y` y aparece el escritorio del servidor.
