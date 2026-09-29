# SNMP

_Simple Network Management Protocol_

Protocolo de red utilizado para monitorizar y administrar dispositivos y servidores. Permite consultar información del sistema, interfaces, configuración y otros datos expuestos por un agente SNMP.

Puerto **161 UDP** → SNMP
Puerto **162 UDP** → SNMP traps/notifications
Puerto **199 TCP** → SMUX, relacionado con la infraestructura SNMP

## Escaneo

- Escaneo del puerto smux en TCP
```bash
nmap -sCV -p199 target
```

- Detectar si SNMP está expuesto en UDP
```bash
nmap -sU -p161 target
```

## Descubrir Community String

La _community string_ es utilizada por SNMPv1/v2c para autenticar consultas.

- Probar la community por defecto
```bash
snmpwalk -v1 -c public target
```

- Buscar diccionario
```bash
find /usr/share/seclists -iname '*snmp*' -o -iname '*community*'
```

- Buscar community strings con **onesixtyone**
```bash
onesixtyone -c /usr/share/seclists/Discovery/SNMP/common-snmp-community-strings.txt target
```

Resultado típico:
`target [community string] Linux target...`

## Enumeración SNMP

- Hacer un SNMP walk completo
```bash
snmpwalk -v1 -c commstring target
```

- SNMPv2c
```bash
snmpwalk -v2c -c commstring target
```

- Consultar el árbol completo desde la raíz
```bash
snmpwalk -v1 -c commstring target 1
```

- Consultar una rama concreta del árbol OID
`snmpwalk -v1 -c commstring target 1.3.6.1.2.1.1`

## OIDs importantes

El árbol de OIDs organiza la información de SNMP.

**Información estándar del sistema:**
`1.3.6.1.2.1.1`

Puede mostrar:
- `sysDescr` → sistema/versión
- `sysObjectID` → identificador del agente
- `sysUpTime` → tiempo de actividad
- `sysContact` → contacto
- `sysName` → hostname
- `sysLocation` → ubicación

**Enterprise / MIBs privadas:**
`1.3.6.1.4.1`
Aquí pueden aparecer datos específicos del fabricante, aplicación o laboratorio.

- Consultar MIBs privadas
`snmpwalk -v1 -c commstring target 1.3.6.1.4.1`

## Obtención de información Hexadecimal

Para ver el nombre en lugar de iso.X.X.X.X vamos a abrir la configuración de snmp y comentar la línea *#mibs*
```bash
nano /etc/snmp/snmp.conf
```

Descifrar hex
```bash
echo 'XX XX XX ..' | xargs | xxd -ps -r
```
