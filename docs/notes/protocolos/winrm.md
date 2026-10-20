-i-i# WinRM

*Windows Remote Management
*
Protocolo de administración remota de Windows por línea de comandos. Usa **SOAP** para conectar con hosts remotos. **WinRS** (Windows Remote Shell) es el componente que permite ejecutar comandos arbitrarios en el sistema remoto. Lo usan las sesiones remotas de PowerShell.

Puerto **5985 TCP** → WinRM sobre HTTP
Puerto **5986 TCP** → WinRM sobre HTTPS

Habilitado por defecto desde Windows Server 2012. En la práctica suele verse solo el **5985 (HTTP)**.

## Footprinting

* Escaneo de los puertos WinRM
```bash
nmap -sV -sC target -p5985,5986 --disable-arp-ping -n
```

El `5985` suele aparecer como `Microsoft HTTPAPI httpd 2.0`.

* Comprobar acceso desde Windows (PowerShell)
```powershell
Test-WsMan target
```

## Conexión

* Desde Linux con evil-winrm (da una shell remota)
```bash
evil-winrm -i target -u usuario -p password
```
Usuario común -> **Administrator**

Devuelve una consola PowerShell en el host remoto (`*Evil-WinRM* PS C:\...>`). Herramienta clave para pentest.
