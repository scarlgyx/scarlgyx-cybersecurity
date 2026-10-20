# WMI

*Windows Management Instrumentation*

Implementación de Microsoft de CIM/WBEM. Permite acceso de **lectura y escritura a casi toda la configuración** de un sistema Windows → la interfaz más crítica para administración remota. Se accede vía PowerShell, VBScript o WMIC. No es un programa único, sino varios programas y repositorios (bases de datos).

Puerto **135 TCP** → WMI (inicio de la comunicación; luego salta a un puerto aleatorio)

## Footprinting y ejecución

* Ejecutar comandos en remoto con wmiexec.py (Impacket)
```bash
wmiexec.py usuario:"password"@target "hostname"
```

Devuelve la salida del comando ejecutado en el host remoto (en el ejemplo, el hostname `ILF-SQL-01`). Permite ejecución de comandos arbitrarios con credenciales válidas.
