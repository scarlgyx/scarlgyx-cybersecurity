# DNS

*Domain Name System*

![700](../../assets/img/Pasted%20image%2020261015185801.png)

Sistema que resuelve nombres de dominio a direcciones IP. No tiene base de datos central: la información está distribuida en miles de servidores de nombres por todo el mundo. También almacena info adicional del dominio (servidores de correo, nameservers, etc.).

Puerto **53 UDP** → consultas DNS normales
Puerto **53 TCP** → transferencias de zona y respuestas >512 bytes

El DNS no va cifrado por defecto → se puede espiar. Soluciones: DoT (DNS sobre TLS), DoH (DNS sobre HTTPS), DNSCrypt.

*Tipos de servidor*
* `DNS Root Server` → responsables de los TLD, última instancia. Hay 13 en el mundo (los coordina ICANN)
* `Authoritative Nameserver` → tiene autoridad sobre una zona, su respuesta es vinculante
* `Non-authoritative Nameserver` → no es responsable de la zona, recopila la info por consultas recursivas/iterativas
* `Caching Server` → cachea info de otros nameservers un tiempo determinado
* `Forwarding Server` → solo reenvía consultas a otro servidor DNS
* `Resolver` → hace la resolución localmente en el equipo o router

## Registros DNS

| Tipo    | Nombre completo       | Descripción                                                                                                                    | Ejemplo (archivo de zona)                                                                    |
| ------- | --------------------- | ------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------- |
| `A`     | Address record        | Mapea un nombre de host a su dirección IPv4                                                                                    | `www.example.com. IN A 192.0.2.1`                                                            |
| `AAAA`  | IPv6 address record   | Mapea un nombre de host a su dirección IPv6                                                                                    | `www.example.com. IN AAAA 2001:db8:85a3::8a2e:370:7334`                                      |
| `CNAME` | Canonical name record | Crea un alias de un nombre de host, apuntándolo a otro                                                                         | `blog.example.com. IN CNAME webserver.example.net.`                                          |
| `MX`    | Mail exchange record  | Servidor(es) de correo responsables del dominio                                                                                | `example.com. IN MX 10 mail.example.com.`                                                    |
| `NS`    | Nameserver record     | Delega una zona a un nameserver autoritativo                                                                                   | `example.com. IN NS ns1.example.com.`                                                        |
| `TXT`   | Text record           | Texto arbitrario; verificación de dominio o políticas de seguridad (SPF, DKIM, DMARC)                                          | `example.com. IN TXT "v=spf1 mx -all"`                                                       |
| `SOA`   | Start of authority    | Info administrativa de la zona: nameserver primario, email del responsable y parámetros. El `.` del email se sustituye por `@` | `example.com. IN SOA ns1.example.com. admin.example.com. 2024060301 10800 3600 604800 86400` |
| `SRV`   | Service record        | Nombre de host y puerto de un servicio concreto                                                                                | `_sip._udp.example.com. IN SRV 10 5 5060 sipserver.example.com.`                             |
| `PTR`   | Pointer record        | Búsqueda inversa (reverse lookup): IP → nombre                                                                                 | `1.2.0.192.in-addr.arpa. IN PTR www.example.com.`                                            |

## Configuración por defecto

Bind9 es el servidor DNS más usado en Linux. Tres tipos de ficheros de configuración:
* config local → `named.conf` (`.local`, `.options`, `.log`)
* ficheros de zona → forward records en formato BIND (la "guía telefónica")
* ficheros de resolución inversa → registros PTR

Un fichero de zona debe tener exactamente un registro `SOA` y al menos un `NS`. Un error de sintaxis invalida toda la zona → el servidor responde `SERVFAIL`.

Opciones peligrosas (en `named.conf`)
* `allow-query` → qué hosts pueden enviar solicitudes al servidor
* `allow-recursion` → qué hosts pueden enviar solicitudes recursivas
* `allow-transfer` → qué hosts pueden recibir transferencias de zona (**clave**: si está en `any` o una subred amplia, cualquiera descarga la zona entera)
* `zone-statistics` → recopila estadísticas de las zonas

## Footprinting

* Consultar los nameservers del dominio
```bash
dig ns domain.htb @target
```

* Consultar la versión del servidor (CHAOS/TXT, si existe la entrada)
```bash
dig CH TXT version.bind @target
```

* Ver todos los registros que el servidor revele
```bash
dig any domain.htb @target
```

* Consulta inversa de registro PTR
```bash
dig -x ip
```

1. Cabecera
    - `;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 16449`: Esta línea indica el tipo de consulta (`QUERY`), el estado exitoso (`NOERROR`) y un identificador único (`16449`) para esta consulta específica.
        - `;; flags: qr rd ad; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0`: Esto describe las banderas en la cabecera DNS:
            - `qr`: Bandera de Respuesta a la Consulta (Query Response) - indica que esto es una respuesta.
            - `rd`: Bandera de Recursión Deseada (Recursion Desired) - significa que se solicitó recursión.
            - `ad`: Bandera de Datos Auténticos (Authentic Data) - significa que el resolutor considera que los datos son auténticos.
            - Los números restantes indican la cantidad de entradas en cada sección de la respuesta DNS: 1 pregunta, 1 respuesta, 0 registros de autoridad y 0 registros adicionales.
    - `;; WARNING: recursion requested but not available`: Esto indica que se solicitó recursión, pero el servidor no la soporta.
2. Sección de Pregunta
    - `;google.com. IN A`: Esta línea especifica la pregunta: "¿Cuál es la dirección IPv4 (registro A) para `google.com`?"
3. Sección de Respuesta
    - `google.com. 0 IN A 142.251.47.142`: Esta es la respuesta a la consulta. Indica que la dirección IP asociada con `google.com` es `142.251.47.142`. El '`0`' representa el `TTL` (tiempo de vida), que indica cuánto tiempo puede almacenarse en caché el resultado antes de ser actualizado.
4. Pie de página
    - `;; Query time: 0 msec`: Esto muestra el tiempo que tardó en procesarse la consulta y recibirse la respuesta (0 milisegundos).
    - `;; SERVER: 172.23.176.1#53(172.23.176.1) (UDP)`: Esto identifica el servidor DNS que proporcionó la respuesta y el protocolo utilizado (UDP).
    - `;; WHEN: Thu Jun 13 10:45:58 SAST 2024`: Esta es la marca de tiempo de cuándo se realizó la consulta.
    - `;; MSG SIZE rcvd: 54`: Esto indica el tamaño del mensaje DNS recibido (54 bytes).

A veces puede existir una `pseudosección opt` en una consulta `dig`. Esto se debe a los Mecanismos de Extensión para DNS (`EDNS`), que permiten características adicionales como tamaños de mensaje más grandes y soporte para Extensiones de Seguridad DNS (`DNSSEC`).

## Qué es un FQDN

**FQDN** = _Fully Qualified Domain Name_, nombre de dominio completamente cualificado. Es el nombre completo de una máquina, con todos sus niveles hasta el dominio. Por ejemplo `ns.inlanefreight.htb` o `mail1.inlanefreight.htb`: el host (`ns`, `mail1`) más el dominio (`inlanefreight.htb`). Es el nombre entero que identifica a un equipo de forma única.
## Transferencia de zona (AXFR)

Transferencia del fichero de zona completo entre servidores, sobre **TCP 53**. Sincroniza el primario (master) con los secundarios (slaves). Si `allow-transfer` está mal configurado, se descarga toda la zona → IPs y hostnames internos.

* Volcar la zona del dominio
```bash
dig axfr domain.htb @target
```

* Volcar una zona interna descubierta
```bash
dig axfr internal.domain.htb @target
```

## Fuerza bruta de subdominios

Cuando no hay AXFR, se descubren los registros A probando una wordlist.

* Bucle en Bash con dig
```bash
for sub in $(cat subdomains.txt);do dig $sub.domain.htb @target | grep -v ';\|SOA' | sed -r '/^\s*$/d' | grep $sub | tee -a found.txt;done
```

* Con dnsenum (AXFR + versión + fuerza bruta)
```bash
dnsenum --dnsserver target --enum -p 0 -s 0 -o subdomains.txt -f /usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt domain.htb
```
`dnsenum` → la herramienta. Hace varias cosas de golpe: busca los registros del dominio (A, NS, MX), intenta una transferencia de zona (AXFR) y, si falla, pasa a fuerza bruta de subdominios.
`--dnsserver target` → le dice que lance todas las consultas contra ese servidor DNS en concreto (la IP del objetivo), en vez de usar el resolver por defecto de tu sistema
 `--enum` → un atajo que activa las opciones de enumeración más comunes. Equivale a poner `--threads 5 -s 15 -w` enumeración estándar con whois y búsqueda de registros.
`-p 0` → _pages_. Número de páginas de resultados de Google a rastrear para scraping de subdominios. A `0` lo desactiva (no scrapea Google).
`-s 0` → _scrap_. Máximo de subdominios a extraer de Google. También a `0`, desactivado. Entre `-p 0` y `-s 0` le estás diciendo "no uses Google, céntrate solo en el servidor DNS que te doy".
`-o subdomains.txt` → _output_. Guarda los resultados en ese fichero.
`-f subdomains-top1million-110000.txt` → _file_. El diccionario de nombres para la fuerza bruta de subdominios (aquí uno de SecLists). dnsenum irá probando `nombre.domain.htb` por cada entrada de la lista.
`domain.htb` → el dominio objetivo a enumerar.