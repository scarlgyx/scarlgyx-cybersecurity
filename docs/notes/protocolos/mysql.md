# MySQL

*My Structured Query Language*

Sistema gestor de bases de datos relacional open-source (de Oracle). Funciona cliente-servidor: el servidor almacena los datos en tablas (filas, columnas, tipos) y los clientes consultan/editan con SQL. Las BBDD se exportan como un `.sql` (p. ej. `wordpress.sql`).

Puerto **3306 TCP** → MySQL / MariaDB

**MariaDB** es un fork de MySQL (mismo código, creado por el dev original tras la compra por Oracle). Se usa en el stack **LAMP** (Linux, Apache, MySQL, PHP) o **LEMP** (con Nginx). Ejemplo típico: WordPress guarda usuarios, posts y contraseñas en su BBDD. Las contraseñas suelen ir cifradas por PHP, pero a veces están en texto plano.

## Configuración peligrosa

Fichero de config: `/etc/mysql/mysql.conf.d/mysqld.cnf`. Opciones sensibles:

* `user` / `password` → usuario y contraseña del servicio, **en texto plano** en el fichero → si lo lees (LFI, shell), tienes acceso a la BBDD
* `admin_address` → IP de escucha de la interfaz administrativa
* `debug` → nivel de depuración
* `sql_warnings` → devuelve info detallada en los INSERT de una fila
* `secure_file_priv` → limita import/export de datos

`debug` y `sql_warnings` sueltan mensajes de error verbosos (útiles para SQL injection si se muestran en la web).

## Footprinting

* Escaneo con versión y todos los scripts mysql
```bash
sudo nmap target -sV -sC -p3306 --script mysql*
```

Scripts útiles: `mysql-info` (versión, protocolo, capacidades), `mysql-empty-password`, `mysql-enum` (usuarios), `mysql-brute`, `mysql-databases`, `mysql-users`, `mysql-variables`.

**Ojo**: los scripts dan falsos positivos (p. ej. marcar `root:<empty>` como válido cuando no lo es). Siempre confirmar a mano conectándose.

## Interacción

* Conectar al servidor (sin espacio entre `-p` y la contraseña)
```bash
mysql -u root -pP4SSw0rd -h target
```

* Sin contraseña (pedirá si hace falta)
```bash
mysql -u root -h target
```

* Para ignorar certificado TLS
```bash
mysql -u root -h target --skip-ssl
```

## Comandos SQL

* `show databases;` → lista todas las BBDD
* `use <database>;` → selecciona una BBDD
* `show tables;` → lista las tablas de la BBDD
* `show columns from <tabla>;` → columnas de una tabla
* `select * from <tabla>;` → todo el contenido de una tabla
* `select * from <tabla> where <columna> = "<texto>";` → busca un valor
* `select version();` → versión del servidor

BBDD del sistema que siempre existen: `information_schema` y `sys` (metadatos), `mysql` (incluye la tabla `user` con las cuentas) y `performance_schema`.
