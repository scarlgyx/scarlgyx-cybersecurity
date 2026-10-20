# MSSQL

*Microsoft SQL Server*

Sistema gestor de bases de datos relacional de Microsoft, de código cerrado, escrito originalmente para Windows (hay versiones Linux/macOS, pero lo normal es encontrarlo en Windows). Muy usado con el framework **.NET**. Usa el lenguaje **T-SQL** (Transact-SQL).

Puerto **1433 TCP** → MSSQL (instancia por defecto)
Puerto **1434 UDP** → SQL Server Browser (DAC, descubrimiento de instancias)

## Clientes

* `SSMS` (SQL Server Management Studio) → cliente gráfico de admin. Es client-side, puede estar en cualquier host con **credenciales guardadas**
* `mssqlclient.py` (Impacket) → el más útil para pentest, viene en las distros (`impacket-mssqlclient`)
* Otros: mssql-cli, SQL Server PowerShell, HeidiSQL, SQLPro

Localizar el cliente de Impacket:
```bash
locate mssqlclient
```

## Bases de datos del sistema

* `master` → info de sistema de toda la instancia
* `model` → plantilla para cada BBDD nueva
* `msdb` → la usa el SQL Server Agent para programar trabajos y alertas
* `tempdb` → objetos temporales
* `resource` → solo lectura, objetos del sistema

## Configuración y fallos peligrosos

Por defecto el servicio corre como `NT SERVICE\MSSQLSERVER`, admite **Windows Authentication** y **no exige cifrado**. Con Windows Auth, el login lo valida el SO (SAM local o Active Directory) → si se compromete una cuenta, puede llevar a escalada de privilegios y movimiento lateral en el dominio.

Puntos a revisar:
* Clientes que conectan **sin cifrado**
* Certificados **autofirmados** (se pueden suplantar)
* Uso de **named pipes** (canalizaciones con nombre)
* Cuenta **`sa`** con credenciales débiles/por defecto (el admin olvida deshabilitarla)

## Footprinting

* Escaneo con scripts NSE de MSSQL

```bash
sudo nmap --script ms-sql-info,ms-sql-empty-password,ms-sql-ntlm-info,ms-sql-config -sV -p1433 target
```

Con argumentos (usuario sa, instancia):
```bash
sudo nmap --script ms-sql-info,ms-sql-ntlm-info --script-args mssql.instance-port=1433,mssql.username=sa,mssql.password=,mssql.instance-name=MSSQLSERVER -sV -p1433 target
```

Da: hostname, nombre de instancia, versión y si tiene named pipes.

* Con Metasploit (mssql_ping)

```bash
msf6 > use auxiliary/scanner/mssql/mssql_ping
set rhosts target
run
```

## Interacción

* Conectar con Windows Authentication (usar este si existe TLS)
```bash
python3 mssqlclient.py Administrator@target -windows-auth
```
Es posible que haya que hacer un *locate mssqlclient.py* antes para usar el path absoluto a la herramienta

* Conectar con usuario/contraseña de SQL desde máquina externa
```bash
impacket-mssqlclient usuario:password@target
```

* Listar bases de datos (ya en la shell `SQL>`)
```sql
select name from sys.databases
```

Nota: las BBDD por defecto son master, tempdb, model y msdb; cualquier otra que aparezca es **no-default** (la interesante).

## Interacción local con sqlcmd (desde una shell en el Windows)

Si ya tienes una shell en el servidor Windows (p. ej. vía evil-winrm) pero el puerto 1433 no escucha en remoto, puedes consultar el SQL **localmente** con `sqlcmd`, la herramienta CLI que instala el propio SQL Server. Se conecta a la instancia local, así que no necesita que el 1433 esté expuesto a la red.

Pistas de que hay un SQL Server en el host: una cuenta `sa`, la pista del lab, o una ruta tipo `C:\SQL2019\...` en el prompt.

- Listar las bases de datos (descartar master, model, msdb, tempdb)
```bash
sqlcmd -Q "SELECT name FROM sys.databases"
```

- Listar las tablas de una base de datos concreta (con -d)
```bash
sqlcmd -d <BBDD> -Q "SELECT table_name FROM information_schema.tables"
```

- Leer el contenido de una tabla
```bash
sqlcmd -d <BBDD> -Q "SELECT * FROM <tabla>"
```

Notas de sintaxis (MSSQL ≠ MySQL):

- NO existe `SHOW TABLES` ni `SHOW DATABASES` (eso es MySQL). Se usa `sys.databases` e `information_schema.tables`
- Hay que indicar la base de datos correcta con `-d`; si no, `SELECT * FROM <tabla>` busca en la BBDD por defecto (master) y devuelve 0 filas o error
- `use <nombre>` solo cambia el contexto de BBDD; si `use accounts` funciona, `accounts` es el nombre de la BASE DE DATOS, no de la tabla

